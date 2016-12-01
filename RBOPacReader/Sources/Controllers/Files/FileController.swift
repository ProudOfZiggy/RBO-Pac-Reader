//
//  FileController.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 09.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

protocol FileControllerProtocol {
    associatedtype T
    var file: T? { get set }
}
