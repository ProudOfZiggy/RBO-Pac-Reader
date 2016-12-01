//
//  DATPose.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 23.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

class DATPose {
    private(set) var bodyParts: Array<DATBodyPart> = []
    
    init(bodyParts: [DATBodyPart]) {
        self.bodyParts = bodyParts
    }
}
