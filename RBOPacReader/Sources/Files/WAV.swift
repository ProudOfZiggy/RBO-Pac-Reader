//
//  WAV.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 09.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Foundation

class WAVFile: BinaryFile {
    private(set) var wavData: Data!
    
    init(wavData: Data) {
        self.wavData = wavData
    }
}
