//
//  ViewController.swift
//  Keyboard Installer
//
//  Created by John Brownie on 9/11/17.
//  Copyright © 2017 John Brownie. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSDraggingDestination {

	@IBOutlet var currentUserButton: NSButton!
	@IBOutlet var allUsersButton: NSButton!
	@IBOutlet var keyboardLayoutName: NSTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}
	
	override func viewDidAppear() {
		super.viewDidAppear()
		self.view.registerForDraggedTypes([NSPasteboard.PasteboardType(rawValue: kUTTypeURL as String)])
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	
	@IBAction func installForAllUsers(_ sender: AnyObject) {
		(NSApp.delegate as? AppDelegate)?.installForAllUsers(sender)
	}
	
	@IBAction func installForCurrentUser(_ sender: AnyObject) {
		(NSApp.delegate as? AppDelegate)?.installForCurrentUser(sender)
	}
	
	func notifyNewDocument(_ fileName: String) {
		keyboardLayoutName.stringValue = fileName
	}
}

