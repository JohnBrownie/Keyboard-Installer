//
//  KIErrors.swift
//  Keyboard Installer
//
//  Created by John Brownie on 9/11/17.
//  Copyright © 2017 John Brownie. All rights reserved.
//

import Foundation

let kKIDomain = "org.sil.KI"

// Recipe 6-1 from The Swift Developer's Cookbook
public protocol ExplanatoryErrorType: Error, CustomDebugStringConvertible {
	var reason: String {get}
	var debugDescription: String {get}
}

public extension ExplanatoryErrorType {
	var debugDescription: String {
		// Adjust for however you want the error to print
		return "\(type(of: self)): \(reason)"
	}
}

public struct KIError: ExplanatoryErrorType {
	public let reason: String
}

public struct KIErrorCode: ExplanatoryErrorType {
	public let reason: String
	public let code: Int
}

let errorHelperToolNotInstalled = KIErrorCode(reason: "Could not install helper tool", code: 1)
let errorFileOperationError = KIErrorCode(reason: "File operation error", code: 2)
