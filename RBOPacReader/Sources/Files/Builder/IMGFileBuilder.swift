//
//  IMGFileBuilder.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 09.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

class IMGFileBuilder: BinaryFileBuilder<IMGFile> {
    
    override func buildFile(fromOpenedStream stream: InputStream) {
        let signature = stream.readBytes(count: 4)
        
        if signature != IMGFile.signature {
            debugPrint("FAILED")
            return
        }
        
        let buffer = stream.readBytes(count: 4)
        var isUnknown = false
        
        for unknownBuffer in IMGFile.unknown {
            if buffer == unknownBuffer {
                break
            } else {
                isUnknown = true
            }
        }
        
        if isUnknown {
            debugPrint("Invalid value")
            return
        }
        
        let num3 = stream.readInt32() * 2
        let width = stream.readInt32()
        let height = stream.readInt32()
        let num6 = width * height
        let count = num6 * num3
        var source = stream.readBytes(count: count)

        if let bitmapRepresentation = NSBitmapImageRep.representation32bppArgb(data: &source, width: width, height: height) {
            file = IMGFile(bitmap: bitmapRepresentation)
        } else {
            debugPrint("Unable to read IMG")
            return
        }
    }
}
