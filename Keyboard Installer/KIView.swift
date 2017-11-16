//
//  KIView.swift
//  Keyboard Installer
//
//  Created by John Brownie on 16/11/17.
//  Copyright © 2017 John Brownie. All rights reserved.
//

import Cocoa

class KIView: NSView {
	override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
		let pasteBoard = sender.draggingPasteboard()
		if let draggedURLs = pasteBoard.readObjects(forClasses: [NSURL.classForCoder()], options: nil) {
			if draggedURLs.count > 0 {
				if let theURL = draggedURLs[0] as? URL {
					if theURL.pathExtension == "keylayout" || theURL.pathExtension == "bundle" {
						return .generic
					}
				}
			}
		}
		return []
	}
	
	override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
		let pasteBoard = sender.draggingPasteboard()
		if let draggedURLs = pasteBoard.readObjects(forClasses: [NSURL.classForCoder()], options: nil) {
			if draggedURLs.count > 0 {
				(NSApp.delegate as? AppDelegate)?.currentDocument = draggedURLs[0] as? URL
			}
		}
		return true
	}
}
