//
//  BodyPartBuilder.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 23.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

struct BodyPartBuilder {
    lazy var alpha = -1
    lazy var hueABRG = 0
    lazy var imageIndex = 0
    lazy var layer = 0
    lazy var rotation = 0
    
    lazy var unknown = Array<Int>(repeating: 0, count: 5)
    
    lazy var flip: FlipFlag = .none
    
    lazy var imageHalfSize: NSSize = .zero
    lazy var imageHalfPos: NSPoint = .zero
    lazy var origin: NSPoint = .zero
    lazy var scalePop: NSPoint = .zero
    lazy var translation: NSPoint = .zero
    lazy var scale = NSPoint(x: 0x3e8, y: 0x3e8)
}
