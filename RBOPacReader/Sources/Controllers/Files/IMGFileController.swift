//
//  IMGFileController.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 09.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

class IMGFileController: NSViewController, FileControllerProtocol {
    var file: IMGFile?
    @IBOutlet weak var imageView: NSImageView!
    
    convenience init() {
        self.init(nibName: IMGFileController.stringClass, bundle: nil)!
    }
}
