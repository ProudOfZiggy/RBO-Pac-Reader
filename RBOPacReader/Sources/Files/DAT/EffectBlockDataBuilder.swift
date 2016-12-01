//
//  EffectBlockDataBuilder.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 24.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

class EffectBlockDataBuilder {
    lazy var destPos: NSPoint = .zero
    lazy var sourcePos: NSPoint = .zero
    lazy var size: NSSize = .zero
    lazy var textureId = 0
    
    lazy var unused: [UInt8] = [0, 0]
}
