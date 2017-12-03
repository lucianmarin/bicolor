//
//  Document.swift
//  Bicolor
//
//  Created by lucian on 12/2/17.
//  Copyright © 2017 Lucian Marin. All rights reserved.
//

import Cocoa

class Document: NSDocument, NSSplitViewDelegate {
    @IBOutlet var mainWindow: NSWindow!
    @IBOutlet weak var splitView: NSSplitView!
    @IBOutlet weak var leftView: NSView!
    @IBOutlet weak var rightView: NSView!
    @IBOutlet weak var inline: NSButtonCell!
    @IBOutlet weak var leftColorWell: NSColorWell!
    @IBOutlet weak var rightColorWell: NSColorWell!
    @IBOutlet var panel: NSPanel!
    @IBOutlet weak var textField: NSTextField!
    
    let spindrift = NSColor.init(calibratedRed: 0.4, green: 1.0, blue: 0.8, alpha: 1.0)
    let tungsten = NSColor.init(calibratedRed: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
    
    func getLuminance(color: NSColor) -> CGFloat {
        let red = color.redComponent
        let green = color.greenComponent
        let blue = color.blueComponent
        var R = CGFloat(0)
        var G = CGFloat(0)
        var B = CGFloat(0)
        if (red <= 0.03928) {
            R = red/12.92
        } else {
            R = pow((red + 0.055)/1.055, 2.4)
        }
        if (green <= 0.03928) {
            G = green/12.92
        } else {
            G = pow((green + 0.055)/1.055, 2.4)
        }
        if (blue <= 0.03928) {
            B = blue/12.92
        } else {
            B = pow((blue + 0.055)/1.055, 2.4)
        }
        return 0.2126 * R + 0.7152 * G + 0.0722 * B
    }
    
    func getContrastRatio() -> CGFloat {
        let leftLum = getLuminance(color: leftColorWell.color);
        let rightLum = getLuminance(color: rightColorWell.color);
        return round((max(leftLum, rightLum) + 0.05)/(min(leftLum, rightLum) + 0.05)*10)/10;
    }
    
    @IBAction func setLeftColor(sender: AnyObject) {
        leftView.layer?.backgroundColor = leftColorWell.color.cgColor
        textField.backgroundColor = rightColorWell.color
        textField.textColor = leftColorWell.color
        
        inline.title = getContrastRatio().description
        mainWindow.title = getContrastRatio().description
    }
    
    @IBAction func setRightColor(sender: AnyObject) {
        rightView.layer?.backgroundColor = rightColorWell.color.cgColor
        textField.backgroundColor = rightColorWell.color
        textField.textColor = leftColorWell.color
        
        inline.title = getContrastRatio().description
        mainWindow.title = getContrastRatio().description
    }
    
    @IBAction func switchColors(sender: AnyObject) {
        let tempColor = leftColorWell.color
        leftColorWell.color = rightColorWell.color
        rightColorWell.color = tempColor
        setLeftColor(sender: sender)
        setRightColor(sender: sender)
    }
    
    @IBAction func randomColors(sender: AnyObject) {
        leftColorWell.color = NSColor.init(calibratedRed: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        rightColorWell.color = NSColor.init(calibratedRed: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        setLeftColor(sender: sender)
        setRightColor(sender: sender)
    }
    
    @IBAction func togglePanel(sender: AnyObject) {
        if (panel.isVisible) {
            panel.performClose(sender)
        } else {
            panel.makeKeyAndOrderFront(sender)
        }
    }
    
    @IBAction func resetSplitView(sender: AnyObject) {
        let cursor = (mainWindow.frame.width - 1)/2
        splitView.setPosition(cursor, ofDividerAt: 0)
    }
    
    @IBAction func floatOnTop(sender: NSMenuItem) {
        if (mainWindow.level == .normal) {
            mainWindow.level = .floating
            sender.state = .on
        } else {
            mainWindow.level = .normal
            sender.state = .off
        }
    }
    
    func splitViewDidResizeSubviews(_ notification: Notification) {
        let total = leftView.frame.width + rightView.frame.width
        let percent = leftView.frame.width / total * 100
        panel.title = "\(Int(percent))%"
    }

    override func windowControllerDidLoadNib(_ windowController: NSWindowController) {
        super.windowControllerDidLoadNib(windowController)
        mainWindow.titleVisibility = .hidden
        mainWindow.styleMask.insert(.fullSizeContentView)
        
        leftView.layer?.backgroundColor = tungsten.cgColor
        rightView.layer?.backgroundColor = spindrift.cgColor
        
        leftColorWell.color = tungsten
        rightColorWell.color = spindrift
        
        textField.backgroundColor = rightColorWell.color
        textField.textColor = leftColorWell.color
        
        inline.title = getContrastRatio().description
        self.displayName = getContrastRatio().description
    }

    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }
    
    override var isDocumentEdited: Bool {
        return false
    }

    override class var autosavesInPlace: Bool {
        return true
    }

    override var windowNibName: NSNib.Name? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return NSNib.Name("Document")
    }

    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func read(from data: Data, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return false if the contents are lazily loaded.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }


}

