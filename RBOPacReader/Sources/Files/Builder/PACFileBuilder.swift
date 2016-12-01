//
//  PACFileBuilder.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 09.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Foundation

class PACFileBuilder: BinaryFileBuilder<PACFile> {
    
    var filePath: String? {
        get {
            return file?.filePath
        }
        set {
            file?.filePath = newValue
        }
    }
    
    override func buildFile(fromOpenedStream stream: InputStream) {
        let signature = stream.readBytes(count: PACFile.signature.count)
        
        if !stream.hasBytesAvailable {
            debugPrint("File is empty")
            return
        }
        
        if signature != PACFile.signature {
            debugPrint("File is not a PAC file")
            return
        }
        let headerNum = stream.readInt32() ^ PACFile.headerSizeKey
        var files: [File] = []
        
        for i in stride(from: 0, to: headerNum, by: 1) {
            var headerNameNum = 0
            var name = ""
            
            while headerNameNum < PACFile.headerEntryNameSize {
                let headerKeysNum = ((i * headerNameNum) * PACFile.headerEntityKey1) + PACFile.headerEntityKey2
                let byte = stream.readByte() ^ UInt8(headerKeysNum & 0xFF)
                let u = UnicodeScalar(byte)
                let char = Character(u)
                
                if char == "\0" {
                    break
                }
                name.append(char)
                headerNameNum += 1
            }
            
            let seekOrigin = UInt64((PACFile.headerEntryNameSize - headerNameNum) - 1)
            stream.seek(by: seekOrigin)
            
            let startOffset = UInt64(stream.readInt32())
            let size = UInt32(stream.readInt32() ^ PACFile.headerSizeKey)
            
            let file = File(
                parentName: "",
                name: name,
                size: size,
                startOffset: startOffset
            )
            files.append(file)
        }
        file = PACFile(files: files)
    }
}
