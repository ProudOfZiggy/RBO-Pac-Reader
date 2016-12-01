//
//  NSObject.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 10.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Foundation

extension NSObject {
    class var stringClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    var stringClass: String {
        return type(of: self).stringClass
    }
}
