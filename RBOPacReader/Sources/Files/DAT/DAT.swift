//
//  DAT.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 10.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

enum FlipFlag: Int {
    case none
    case horizontal
    case vertical
    case horizontalAndVertical
    
    init(flag: Int) {
        self = FlipFlag(rawValue: flag) ?? .none
    }
}

class DATFile: BinaryFile {
    static let signature: [UInt8] = [0x48, 0x41, 0x4e, 50, 0x52,
                                     0x42, 0x4f, 0x20, 0, 0, 0,
                                     0, 0, 0, 0, 0, 2, 0, 0, 0,
                                     0, 0, 0, 0, 1, 0, 0, 0]
    static let bmpCutterSignature: [UInt8] = [0x42, 0x4d, 80, 0x20,
                                              0x43, 0x75, 0x74, 0x74,
                                              0x65, 0x72, 0x33, 0, 0,
                                              0, 0, 0, 1, 0, 0, 0]
    
    private var poses = OrderedDictionary<String, DATPose>()
    private var effects = OrderedDictionary<String, DATEffect>()
    private var spriteSheets = OrderedDictionary<String, NSBitmapImageRep>()
    var strings: [String] = []
    private var unknownTempValues = UnknownTemp()
    
    static let maxBodyParts = 40
    static let maxEffects = 0xbb8
    static let maxPoses = 0x3e8
    static let maxCharImages = 50
    
    lazy var divisionOffset = 0
    lazy var divisionSize = 0
    lazy var charStructOffset = 0
    lazy var charStructSize = 0
    lazy var effectsOffset: UInt64 = 0
    lazy var effectsSize = 0
    lazy var stringsOffset = 0
    lazy var stringsSize = 0
    
    lazy var part: [[Int]] = []
    lazy var partSizes: [Int] = []
    
    lazy var poseOffsets: [Int] = []
    lazy var poseNames: [String] = []
    lazy var posesBuilders: [Int: PoseBuilder?] = [:]
    
    lazy var charImageDataOffset = 0
    lazy var charImageOffsets: [Int] = []
    lazy var charImageFileNames: [String] = []
    lazy var charImageResolutions: [Int] = []
    lazy var charImageDatasBytes: [[UInt8]] = []
    
    lazy var bmpCuttersInfo: [[UInt8]] = []
    
    lazy var blocksCount = 0
    lazy var blocksOffset: UInt64 = 0
    lazy var blocksGap = 0
    lazy var blocksBuilders: [EffectBlockDataBuilder] = []
    
    lazy var effectsOffsets: [Int] = []
    lazy var effectImageBuilders: [Int: EffectImageDataBuilder] = [:]
    
    lazy var storageType = 0
}
