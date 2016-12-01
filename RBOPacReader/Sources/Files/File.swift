//
//  File.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 09.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Foundation

enum FileType: String {
    case undefined
    
    case WAV
    case IMG
    case DAT
    case FOB
    case PAC
    
    init(type: String) {
        self = FileType(rawValue: type.uppercased()) ?? .undefined
    }
    
    static var allowed: [FileType] {
        return [.WAV, .IMG, .DAT, .FOB, .PAC]
    }
}

struct File {
    private(set) var parentName: String
    private(set) var name: String
    private(set) var type: FileType
    private(set) var size: UInt32
    private(set) var startOffset: UInt64
    
    init(parentName: String, name: String, size: UInt32, startOffset: UInt64) {
        self.parentName = parentName
        self.name = name
        self.size = size
        self.startOffset = startOffset
        self.type = FileType(type: name.extension)
    }
    
    static func files(at url: URL) -> [File] {
        guard let enumerator = FileManager.default.enumerator(
            at: url,
            includingPropertiesForKeys: nil,
            options: .skipsSubdirectoryDescendants,
            errorHandler: nil) else {
                return []
        }
        let filesURLs = enumerator.filter {
            guard let file = $0 as? URL else {
                return false
            }
            return FileType(type: file.pathExtension) != .undefined
        } as! [URL]
        
        var files: [File] = []
        
        for url in filesURLs {
            let attributes = try! FileManager.default.attributesOfItem(atPath: url.path)
            let fileSize = attributes[.size] as? UInt32 ?? 0
            let fileName = url.lastPathComponent
            let file = File(
                parentName: "",
                name: fileName,
                size: fileSize,
                startOffset: 0
            )
            files.append(file)
        }
        return files
    }
}
