//
//  AppDelegate.swift
//  Keyboard Installer
//
//  Created by John Brownie on 9/11/17.
//  Copyright © 2017 John Brownie. All rights reserved.
//

import Cocoa

let systemKeyboardsPath = "/Library/Keyboard Layouts"
let libraryName = "Library"
let keyboardLayoutsName = "Keyboard Layouts"

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	var currentDocument: URL? = nil {
		didSet {
			// Notify the new name
			let theWindow = NSApp.windows[0]
			if let theView = theWindow.contentViewController as? ViewController {
				theView.notifyNewDocument(currentDocument?.lastPathComponent ?? "")
			}
		}
	}
	
	let systemKeyboards = URL(fileURLWithPath: systemKeyboardsPath, isDirectory: true)
	var userKeyboards: URL? = nil

	func applicationWillFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		let fileManager = FileManager.default
		var userHome: URL
		if #available(OSX 10.12, *) {
			userHome = fileManager.homeDirectoryForCurrentUser
		} else {
			// Fallback on earlier versions
			userHome = URL.init(fileURLWithPath: NSHomeDirectory())
		}
		userKeyboards = userHome.appendingPathComponent(libraryName).appendingPathComponent(keyboardLayoutsName)
	}

	func applicationDidFinishLaunching(_ notification: Notification) {
		NSApp.arrangeInFront(self)
	}

	func application(_ sender: NSApplication, openFile filename: String) -> Bool {
		// Open the file if no file currently open
		if currentDocument != nil {
			return false
		}
		currentDocument = URL(fileURLWithPath: filename)
		return true
	}
	
	func installForAllUsers(_ sender: AnyObject) {
		// Install the file...
		if let sourceURL = currentDocument {
			let destinationURL = systemKeyboards.appendingPathComponent(currentDocument!.lastPathComponent)
			KIFileOperations.copy(from: sourceURL, to: destinationURL) { (success, error) in
				// Check for error
				if success {
					currentDocument = nil
					NSApp.terminate(self)
				}
				else {
					NSApp.presentError(error!)
				}
			}
		}
	}
	
	func installForCurrentUser(_ sender: AnyObject) {
		// Install the file...
		if let sourceURL = currentDocument {
			let destinationURL = userKeyboards!.appendingPathComponent(currentDocument!.lastPathComponent)
			KIFileOperations.copy(from: sourceURL, to: destinationURL) { (success, error) in
				// Check for error
				if success {
					currentDocument = nil
					NSApp.terminate(self)
				}
				else {
					NSApp.presentError(error!)
				}
			}
		}
	}

}

