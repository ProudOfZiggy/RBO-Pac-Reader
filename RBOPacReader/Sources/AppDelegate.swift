//
//  AppDelegate.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 07.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ notification: Notification) {

    }
    
    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        let url = URL(fileURLWithPath: filename)
        openDirectory(at: url)
        return true
    }
    
    @IBAction func openFolder(_ sender: Any) {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.begin { (result) in
            if result == NSFileHandlingPanelOKButton,
                let url = openPanel.url {
                self.openDirectory(at: url)
            }
        }
    }
    
    private func openDirectory(at url: URL) {
        if let controller = NSApplication.shared().keyWindow?.windowController?.contentViewController as? MainController {
            controller.openDirectory(at: url)
        }
    }
}

