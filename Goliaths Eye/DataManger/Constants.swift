//
//  Constants.swift
//  Haid3r
//
//  Created by a on 04/10/2020.
//  Copyright © 2020 Haider Awan. All rights reserved.
//

import UIKit

var kApplicationWindow = Utility.getAppDelegate()!.window
var googleAPIKey = "AIzaSyBp9ntlNiyAFvV8qxdXrBvBAOz_xasmvS0"

struct APIRoutes {
    static var baseUrl = "http://182.176.161.38:8080/ibl2/v1.0/users/"
    static var login = "login"
    static var registartion = "createUser"
    static var forgotPassword = "forgotpassword"
    static var logs = "logs"
    static var screenShot = "screenshot"
    static var verifyEmail = "verifyemail"
    static var invites = "getinvites"
    static var sendInvite = "sendinvite"
    
}
struct FireBaseVariables {
    static var fireBaseToken = ""
}
