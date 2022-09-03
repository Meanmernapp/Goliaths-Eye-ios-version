//
//  Global.swift
//  StacyView
//
//  Created by Haider Awan on 11/01/2021.
//

import Foundation
import UIKit
import CoreLocation

class Global {
    class var shared : Global {
        struct Static {
            static let instance : Global = Global()
        }
        return Static.instance
    }
    
    var currentNavigationController = BaseNavigationViewController()
    var is_new_user = true
    var current_lat : Double = 71
    var current_lng : Double = 35
    var fireBaseToken = ""
    
    
    
}
