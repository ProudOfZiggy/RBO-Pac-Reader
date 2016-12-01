//
//  IMG.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 09.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

class IMGFile: BinaryFile {
    static let signature = Array<UInt8>(repeating: 0, count: 4)
    static let unknown: [[UInt8]] = {
        var item = Array<UInt8>(repeating: 0, count: 4)
        item[0] = 7
        var buffer = Array<UInt8>(repeating: 0, count: 4)
        buffer[0] = 6
        return [item, buffer]
    }()
    
    private(set) var bitmap: NSBitmapImageRep!

    init(bitmap: NSBitmapImageRep) {
        self.bitmap = bitmap
    }
}
