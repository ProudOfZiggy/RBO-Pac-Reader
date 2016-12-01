//
//  PAC.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 07.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

class PACFile: BinaryFile {
    static let headerSizeKey = 0xE3DF59AC
    static let headerEntrySize = 0x44
    static let headerEntryNameSize = 60
    static let headerEntityKey1 = 3
    static let headerEntityKey2 = 0x3D
    static let signature: [UInt8] = [1, 0, 0, 0]

    var filePath: String?
    lazy private(set) var files: [File] = []
    
    init(files: [File]) {
        self.files = files
    }
}
