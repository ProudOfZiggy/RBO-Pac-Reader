//
//  PACFileController.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 09.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

class PACFileController: NSViewController, FileControllerProtocol {
    var file: PACFile? {
        didSet {
            reloadData()
        }
    }
    
    func reloadData() {
        //
    }
}
