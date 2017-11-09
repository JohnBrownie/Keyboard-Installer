//
//  KIFileOperations.swift
//  Keyboard Installer
//
//  Created by John Brownie on 9/11/17.
//  Copyright © 2017 John Brownie. All rights reserved.
//

import Foundation

let toolName = "KIFileMover"

struct KIFileOperations {
	static func copy(from source: URL, to destination: URL, completion handler:((Bool, NSError?) -> Void)) {
		let fileManager = FileManager.default
		do {
			try fileManager.createDirectory(at: destination.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
			try fileManager.copyItem(at: source, to: destination)
			handler(true, nil)
		}
		catch let theError as NSError {
			if theError.code == NSFileWriteNoPermissionError {
				// No permission, so we try authenticated
				if let toolPath = Bundle.main.url(forAuxiliaryExecutable: toolName)?.path {
					let sourcePath = source.path
					let destPath = destination.path
					let scriptString = "do shell script quoted form of \"\(toolPath)\" & \" \" & quoted form of \"\(sourcePath)\" & \" \" & quoted form of \"\(destPath)\" with administrator privileges"
					let appleScript = NSAppleScript.init(source: scriptString)
					var errorDict: NSDictionary? = NSDictionary.init()
					appleScript?.executeAndReturnError(&errorDict)
					handler(true, theError)
				}
				else {
					handler(false, theError)
				}
			}
			else {
				handler(false, theError)
			}
		}
		catch {
			handler(false, NSError(domain: kKIDomain, code: errorFileOperationError.code, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]))
		}
	}
}
