//
//  DATEffect.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 23.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

class DATEffect {
    static let emptyColor = NSColor.clear
    
    var enabledBlocks: [[Bool]] = []
    private(set) var bounds: NSRect = .zero
    var imageBitmap: NSBitmapImageRep? {
        didSet {
            enabledBlocks.removeAll()
            updateBounds(withBasePoint: basePoint)
        }
    }
    
    var basePoint: NSPoint {
        get {
            return NSPoint(x: -bounds.origin.x, y: -bounds.origin.y)
        }
        set {
            updateBounds(withBasePoint: newValue)
        }
    }
    
    private func updateBounds(withBasePoint point: NSPoint) {
        bounds = NSRect(
            x: -point.x,
            y: -point.x,
            width: CGFloat(imageBitmap?.pixelsWide ?? 0),
            height: CGFloat(imageBitmap?.pixelsHigh ?? 0)
        )
    }
    
    private func findEnabledBlocks() {
        if let imageBitmap = imageBitmap {
            findEnabledBlocks(in: imageBitmap)
        }
    }
    
    private func findEnabledBlocks(in bitmap: NSBitmapImageRep) {
        let blockX: Int = bitmap.pixelsWide / 0x10
        let blockY: Int = bitmap.pixelsHigh / 0x10
        enabledBlocks.removeAll()
        
        for i in 0..<blockY {
            for j in 0..<blockX {
                enabledBlocks[i][j] = !checkBlockEmptiness(atX: j, y: i)
            }
        }
    }
    
    private func checkBlockEmptiness(atX x: Int, y: Int) -> Bool {
        let blockX = x * 0x10
        let blockY = y * 0x10
        
        for y in blockY..<(blockY + 0x10) {
            for x in blockX..<(blockX + 0x10) {
                if imageBitmap?.colorAt(x: x, y: y) != DATEffect.emptyColor {
                    return false
                }
            }
        }
        return true
    }
}
