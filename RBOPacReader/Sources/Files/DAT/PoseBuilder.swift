//
//  PoseBuilder.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 23.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

class PoseBuilder {
    var partsBuilders = Array<BodyPartBuilder>(repeating: BodyPartBuilder(), count: DATFile.maxBodyParts)
}
