//
//  BinaryFileBuilder.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 09.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Foundation

class BinaryFileBuilder<T: BinaryFile> {

    var file: T?
    private(set) var fileInfo: File?
    
    convenience init() {
        self.init(fileInfo: nil)
    }
    
    required init(fileInfo: File?) {
        self.fileInfo = fileInfo
    }
    
    final func buildFile(fromStream stream: InputStream) {
        if stream.streamStatus == .notOpen {
            stream.open()
        }
        
        if let fileInfo = fileInfo {
            stream.seek(to: fileInfo.startOffset)
        }
        
        buildFile(fromOpenedStream: stream)
        stream.close()
    }
    
    func buildFile(fromOpenedStream stream: InputStream) {
        assert(false, "Method must be overriden in \(self)")
    }
}
