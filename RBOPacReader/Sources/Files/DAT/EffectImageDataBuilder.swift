//
//  EffectImageDataBuilder.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 23.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

class EffectImageDataBuilder {
    lazy var blockSize = 0
    lazy var blockStartOffset = 0
    var name: String?
    lazy var pixels: [UInt8] = []
    lazy var pixelsAddress: UInt64 = 0
    lazy var storageType = 0
    lazy var unused = 0
    
    lazy var unknown = [0x100, 0x100, 0x20, 0x10, 0x70, 0x8f, 0xdf]
}
