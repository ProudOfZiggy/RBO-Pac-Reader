//
//  MainController.swift
//  RBOPacReader
//
//  Created by Nikita Rodionov on 07.11.16.
//  Copyright © 2016 ProudOfZiggy. All rights reserved.
//

import Cocoa
import AVFoundation

class MainController: PACFileController, NSTableViewDelegate, NSTableViewDataSource {
    @IBOutlet weak var pacFilesTableView: NSTableView!
    @IBOutlet weak var pacContainmentTableView: NSTableView!
    @IBOutlet weak var imageView: NSImageView!
    
    @IBOutlet weak var fileControllerContainerView: NSView!
    private var fileController: NSViewController?
    
    private var currentDirectoryURL: URL?
    private var audioPlayer: AVAudioPlayer?
    
    var pacFiles: [File] = [] {
        didSet {
            file = nil
            pacFilesTableView.deselectAll(nil)
            pacFilesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recentURL = NSDocumentController.shared().recentDocumentURLs.first {
            openDirectory(at: recentURL)
        }
    }
    
    override func reloadData() {
        pacContainmentTableView.reloadData()
    }
    
    func openDirectory(at url: URL) {
        if currentDirectoryURL?.path == url.path {
            return
        }
        currentDirectoryURL = url
        pacFiles = File.files(at: url)
        
        if pacFiles.isNotEmpty {
            NSDocumentController.shared().noteNewRecentDocumentURL(url)
        }
    }
    
    func path(of file: File) -> String? {
        return currentDirectoryURL?.appendingPathComponent(file.name, isDirectory: true).path
    }
    
    //MARK: -
    //MARK: NSTableView Delegate
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        if tableView === pacFilesTableView {
            if let path = path(of: pacFiles[row]), let stream = InputStream(fileAtPath: path) {
                let builder = PACFileBuilder()
                builder.buildFile(fromStream: stream)
                builder.filePath = path
                file = builder.file
                return true
            }
        } else if tableView === pacContainmentTableView {
            
            if let pacFile = file, let path = pacFile.filePath, let stream = InputStream(fileAtPath: path) {
                let selectedFile = pacFile.files[row]
                
                if selectedFile.type == .WAV {
                    let builder = WAVFileBuilder(fileInfo: selectedFile)
                    builder.buildFile(fromStream: stream)
                    if let wavFile = builder.file {
                        do {
                            audioPlayer = try AVAudioPlayer(data: wavFile.wavData)
                            audioPlayer?.prepareToPlay()
                            audioPlayer?.play()
                        } catch {}
                    }
                } else if selectedFile.type == .IMG {
                    let builder = IMGFileBuilder(fileInfo: selectedFile)
                    builder.buildFile(fromStream: stream)
                    imageView.image = builder.file?.bitmap.makeImage()
                } else if selectedFile.type == .DAT {
                    let builder = DATFileBuilder(fileInfo: selectedFile)
                    builder.buildFile(fromStream: stream)
                }
            }
            return true
        }
        return false
    }
    
    //MARK: -
    //MARK: NSTableView DataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView === pacFilesTableView {
            return pacFiles.count
        } else {
            return file?.files.count ?? 0
        }
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if tableView === pacFilesTableView {
            return pacFiles[row].name
        } else {
            return file?.files[row].name
        }
    }
}

