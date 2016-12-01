//
//  DATFileBuilder.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 10.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Foundation

class DATFileBuilder: BinaryFileBuilder<DATFile> {
    
    override func buildFile(fromOpenedStream stream: InputStream) {
        let signature = stream.readBytes(count: 0x1c)
        
        if signature != DATFile.signature {
            debugPrint("Wrong DAT File signature")
            return
        }
        
        let datFile = DATFile()
        let unknownTemp = UnknownTemp()
        let initialOffset = stream.seekOrigin
        
        unknownTemp.unknown2 = stream.readInt32()
        datFile.divisionOffset = stream.readInt32()
        datFile.divisionSize = stream.readInt32()
        datFile.charStructOffset = stream.readInt32()
        datFile.charStructSize = stream.readInt32()
        datFile.effectsOffset = UInt64(stream.readInt32())
        datFile.effectsSize = stream.readInt32()
        datFile.stringsOffset = stream.readInt32()
        datFile.stringsSize = stream.readInt32()
        
        if datFile.divisionSize != 0 {
            unknownTemp.unknown3 = stream.readInt32()
            unknownTemp.unknown4 = stream.readInt32()
            unknownTemp.unknown5 = stream.readInt32()
            unknownTemp.unknown6 = stream.readInt32()
            unknownTemp.unknown7 = stream.readInt32()
            unknownTemp.unknown8 = stream.readInt32()
            unknownTemp.unknown9 = stream.readInt32()
            unknownTemp.unknown10 = stream.readInt32()
            unknownTemp.unknown11 = stream.readInt32()
            unknownTemp.unknown12 = stream.readInt32()
            unknownTemp.unknown13 = stream.readInt32()
            
            for _ in 0..<8 {
                datFile.partSizes.append(stream.readInt32())
            }
            unknownTemp.unknown14 = stream.readInt32()
            unknownTemp.unknown15 = stream.readInt32()
            unknownTemp.unknown16 = stream.readInt32()
            
            for i in 0..<8 {
                let nubmerOfParts = datFile.partSizes[i] / 4
                var part: [Int] = []
                
                for _ in 0..<nubmerOfParts {
                    part.append(stream.readInt32())
                }
                datFile.part.append(part)
            }
        }
        
        if datFile.charStructSize != 0 {
            unknownTemp.unknown17 = stream.readBytes(count: 0x18)
            
            for _ in 0..<DATFile.maxPoses {
                datFile.poseOffsets.append(stream.readInt32())
            }
            
            for _ in 0..<DATFile.maxPoses {
                let bytes = stream.readBytes(count: 0x20)
                
                if let poseName = String(bytes: bytes, encoding: .utf8)?.trimmingCharacters(in: .controlCharacters), poseName.isNotEmpty {
                    datFile.poseNames.append(poseName)
                }
            }
            datFile.charImageDataOffset = stream.readInt32()
            
            for i in 0..<DATFile.maxPoses {
                if datFile.poseOffsets[i] == 0 {
                    datFile.posesBuilders.updateValue(nil, forKey: i)
                } else {
                    let poseBuilder = PoseBuilder()
                    
                    for j in 0..<DATFile.maxBodyParts {
                        var bodyBuilder = BodyPartBuilder()
                        bodyBuilder.translation = NSPoint(x: stream.readInt32(), y: stream.readInt32())
                        bodyBuilder.scalePop = NSPoint(x: stream.readInt32(), y: stream.readInt32())
                        bodyBuilder.flip = FlipFlag(flag: stream.readInt32())
                        bodyBuilder.scale = NSPoint(x: stream.readInt32(), y: stream.readInt32())
                        bodyBuilder.rotation = stream.readInt32()
                        bodyBuilder.alpha = stream.readInt32()
                        bodyBuilder.hueABRG = stream.readInt32()
                        bodyBuilder.imageIndex = stream.readInt32()
                        bodyBuilder.imageHalfPos = NSPoint(x: stream.readInt32(), y: stream.readInt32())
                        bodyBuilder.imageHalfSize = NSSize(width: stream.readInt32(), height: stream.readInt32())
                        bodyBuilder.layer = stream.readInt32()
                        bodyBuilder.origin = NSPoint(x: stream.readInt32(), y: stream.readInt32())
                        
                        for k in 0..<5 {
                            bodyBuilder.unknown[k] = stream.readInt32()
                        }
                        poseBuilder.partsBuilders[j] = bodyBuilder
                    }
                    datFile.posesBuilders[i] = poseBuilder
                }
            }
            unknownTemp.unknown20 = stream.readBytes(count: 0x1c)
            
            var charImagesCount = 0
            
            for _ in 0..<DATFile.maxCharImages {
                let charImageOffset = stream.readInt32()
                datFile.charImageOffsets.append(charImageOffset)
                
                if charImageOffset != 0 {
                    charImagesCount += 1
                }
            }
            
            for _ in 0..<DATFile.maxCharImages {
                let bytes = stream.readBytes(count: 0x40)
                
                if let charImageName = String(bytes: bytes, encoding: .utf8)?.trimmingCharacters(in: .controlCharacters), charImageName.isNotEmpty {
                    datFile.charImageFileNames.append(charImageName)
                }
            }
            
            for _ in 0..<DATFile.maxCharImages {
                datFile.charImageResolutions.append(stream.readInt32())
            }
            unknownTemp.unknown = stream.readBytes(count: 0x2004)
            
            for i in 0..<charImagesCount {
                let resolution = datFile.charImageResolutions[i]
                let bytesCount = (resolution * resolution) * 4
                let charImageDataBytes = stream.readBytes(count: bytesCount)
                datFile.charImageDatasBytes.append(charImageDataBytes)
            }
        }
        
        if datFile.effectsSize != 0 {
            let bmpCutterSignature = stream.readBytes(count: 20)
            
            if bmpCutterSignature != DATFile.bmpCutterSignature {
                debugPrint("Wrong DAT File BMP Cutter signature")
                return
            }
            
            for _ in 0..<8 {
                let bmpCutterInfo = stream.readBytes(count: 0x400)
                datFile.bmpCuttersInfo.append(bmpCutterInfo)
            }
            
            for i in 0..<2 {
                unknownTemp.unknown120[i] = stream.readInt32()
            }
            datFile.blocksCount = stream.readInt32()
            unknownTemp.unknown23 = stream.readBytes(count: 0x24)
            
            for _ in 0..<DATFile.maxEffects {
                datFile.effectsOffsets.append(stream.readInt32())
            }
            datFile.blocksOffset = UInt64(stream.readInt32())
            unknownTemp.unknown21 = stream.readInt32()
            datFile.blocksGap = stream.readInt32()
            
            for i in 0..<DATFile.maxEffects {
                let effectOffset = datFile.effectsOffsets[i]
                
                if effectOffset == -1 {
                    continue
                }
                
                debugPrint(initialOffset)
                let newStreamOffset = (initialOffset + UInt64(datFile.effectsOffset)) + UInt64(effectOffset)
                debugPrint(newStreamOffset)
                stream.seek(to: newStreamOffset)
                debugPrint(stream.seekOrigin)
                let effectImageBuilder = EffectImageDataBuilder()
                let bytes = stream.readBytes(count: 0x20)
                
                effectImageBuilder.name = String(bytes: bytes, encoding: .unicode)
                
                var flag = true
                
                while flag {
                    flag = false
                    
                    for (_, builder) in datFile.effectImageBuilders {
                        if builder.name != nil || effectImageBuilder.name != nil {
                            if builder.name == effectImageBuilder.name {
                                flag = true
                            }
                        }
                    }
                }
                debugPrint(i)
                debugPrint(effectImageBuilder.name)
                datFile.storageType = stream.readInt32()
                
                for j in 0..<7 {
                    effectImageBuilder.unknown[j] = stream.readInt32()
                }
                effectImageBuilder.blockStartOffset = stream.readInt32()
                effectImageBuilder.blockSize = stream.readInt16()
                effectImageBuilder.unused = stream.readInt16()
                effectImageBuilder.pixelsAddress = stream.seekOrigin
                datFile.effectImageBuilders[i] = effectImageBuilder
            }
            
            let newStreamOffset = initialOffset + datFile.effectsOffset + datFile.blocksOffset
            stream.seek(to: newStreamOffset)
            
            for _ in 0..<datFile.blocksCount {
                let effectBlockDataBuilder = EffectBlockDataBuilder()
                effectBlockDataBuilder.destPos = NSPoint(x: stream.readInt32(), y: stream.readInt32())
                effectBlockDataBuilder.size = NSSize(width: stream.readInt32(), height: stream.readInt32())
                effectBlockDataBuilder.sourcePos = NSPoint(x: stream.readInt16(), y: stream.readInt16())
                effectBlockDataBuilder.textureId = stream.readInt16()
                effectBlockDataBuilder.unused = stream.readBytes(count: 2)
                datFile.blocksBuilders.append(effectBlockDataBuilder)
            }
            let currentOffset = stream.seekOrigin
            
            for i in 0..<DATFile.maxEffects {
                guard let effectBuilder = datFile.effectImageBuilders[i], datFile.effectsOffsets[i] == -1 else {
                    continue
                }
                var effectFirstPartSize = 0
                var effectSecondPartSize = 0
                
                switch effectBuilder.storageType {
                case 1:
                    effectSecondPartSize = 4
                case 2:
                    effectFirstPartSize = 0x400
                    effectSecondPartSize = 1
                case 3:
                    effectFirstPartSize = 4
                    effectSecondPartSize = 1
                case 4:
                    effectFirstPartSize = 0x400
                    effectSecondPartSize = 2
                default:
                    debugPrint("Unknown effect storage type")
                    return
                }
                var effectResolution = 0
                
                for j in effectBuilder.blockStartOffset..<(effectBuilder.blockStartOffset + effectBuilder.blockSize) {
                    let blockBuilder = datFile.blocksBuilders[j]
                    effectResolution += Int(blockBuilder.size.width * blockBuilder.size.height)
                }
                let effectSize = (effectResolution * effectSecondPartSize) + effectFirstPartSize
                stream.seek(to: effectBuilder.pixelsAddress)
                datFile.effectImageBuilders[i]?.pixels = stream.readBytes(count: effectSize)
            }
            stream.seek(to: currentOffset)
            
            if datFile.stringsSize != 0 {
                for _ in 0..<0x100 {
                    let bytes = stream.readBytes(count: 0x40)
                    
                    if let string = String(bytes: bytes, encoding: .utf8)?.trimmingCharacters(in: .controlCharacters), string.isNotEmpty {
                        datFile.strings.append(string)
                    }
                }
            }
        }
    }
}
