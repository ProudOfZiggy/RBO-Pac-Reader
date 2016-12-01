//
//  DATBodyPart.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 23.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

class DATBodyPart {
    static let defaultColor = NSColor.black
    static let defaultFlip: FlipFlag = .none
    static let defaultLayer = 0
    static let defaultOrigin: NSPoint = .zero
    static let defaultRect: NSRect = .zero
    static let defaultRotation = 0.0
    static let defaultScale = 1.0
    static let defaultSpriteSheet: NSBitmapImageRep? = nil
    
    lazy var color = DATBodyPart.defaultColor
    lazy var destinationRect = DATBodyPart.defaultRect
    lazy var flip = DATBodyPart.defaultFlip
    lazy var layer = DATBodyPart.defaultLayer
    lazy var origin = DATBodyPart.defaultOrigin
    lazy var rotation = DATBodyPart.defaultRotation
    lazy var spriteSheet = DATBodyPart.defaultSpriteSheet
    lazy var sourceRect = DATBodyPart.defaultRect
    
    lazy var scale = NSPoint(x: DATBodyPart.defaultScale, y: DATBodyPart.defaultScale)
    
    func reset() {
        color = DATBodyPart.defaultColor
        destinationRect = DATBodyPart.defaultRect
        flip = DATBodyPart.defaultFlip
        layer = DATBodyPart.defaultLayer
        origin = DATBodyPart.defaultOrigin
        rotation = DATBodyPart.defaultRotation
        spriteSheet = DATBodyPart.defaultSpriteSheet
        sourceRect = DATBodyPart.defaultRect
        scale = NSPoint(x: DATBodyPart.defaultScale, y: DATBodyPart.defaultScale)
    }
}
