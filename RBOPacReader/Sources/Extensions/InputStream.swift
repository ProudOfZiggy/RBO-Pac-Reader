//
//  InputStream.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 07.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Foundation

extension InputStream {
    var seekOrigin: UInt64 {
        return self.property(forKey: .fileCurrentOffsetKey) as? UInt64 ?? 0
    }
    
    func readBytes(count: Int) -> [UInt8] {
        var buffer = Array<UInt8>(repeating: 0, count: count)
        self.read(&buffer, maxLength: count)
        return buffer
    }
    
    func seek(by offset: UInt64) {
        self.setProperty(seekOrigin + offset, forKey: .fileCurrentOffsetKey)
    }
    
    func seek(to offset: UInt64) {
        self.setProperty(offset, forKey: .fileCurrentOffsetKey)
    }
    
    func filledBuffer(count: Int) -> [UInt8] {
        return readBytes(count: count).reversed()
    }
    
    func readInt32() -> Int {
        return readInt(witSize: 4)
    }
    
    func readInt16() -> Int {
        return readInt(witSize: 2)
    }
    
    func readInt(witSize size: Int) -> Int {
        let bytes = filledBuffer(count: size)
        var int = Int(0)
        
        for byte in bytes {
            int <<= 8
            int |= Int(byte)
        }
        return int
    }
    
    func readByte() -> UInt8 {
        return readBytes(count: 1)[0]
    }
}
