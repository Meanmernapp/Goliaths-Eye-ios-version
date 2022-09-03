//
//  UIFont.swift
//  Audtix
//
//  Created by Bilal Saeed on 9/13/19.
//  Copyright © 2019 Bilal Saeed. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func font(withSize: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: withSize)!
    }
    
    class func boldFont(withSize: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: withSize)!
    }
}
