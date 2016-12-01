//
//  NSBitmapImageRep.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 22.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

extension NSBitmapImageRep {
    
    convenience init?(data: UnsafeMutableRawPointer?, width: Int, height: Int, bitsPerComponent: Int, bytesPerRow: Int, space: CGColorSpace, bitmapInfo: UInt32) {
        let context = CGContext(data: data,
                                width: width,
                                height: height,
                                bitsPerComponent: bitsPerComponent,
                                bytesPerRow: bytesPerRow,
                                space: space,
                                bitmapInfo: bitmapInfo)
        if let imageRef = context?.makeImage() {
            self.init(cgImage: imageRef)
        } else {
            return nil
        }
    }
    
    static func representation32bppArgb(data: UnsafeMutableRawPointer?, width: Int, height: Int) -> NSBitmapImageRep? {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
        return NSBitmapImageRep(data: data,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: width * 4,
                                space: colorSpace,
                                bitmapInfo: bitmapInfo)
    }
    
    func makeImage() -> NSImage {
        let image = NSImage()
        image.addRepresentation(self)
        return image
    }
}
