//
//  WAVFileBuilder.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 09.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Foundation

class WAVFileBuilder: BinaryFileBuilder<WAVFile> {
    
    override func buildFile(fromOpenedStream stream: InputStream) {
        if let fileInfo = fileInfo {
            let bytes = stream.readBytes(count: Int(fileInfo.size))
            let data = Data(bytes: bytes)
            file = WAVFile(wavData: data)
        } else {
            debugPrint("FAILED")
        }
    }
}
