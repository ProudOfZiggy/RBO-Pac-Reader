//
//  String.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 07.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Foundation

extension String {
    var `extension`: String {
        return components(separatedBy: ".").last ?? ""
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    func insert(string: String, ind: Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
}
