//
//  UIButton.swift
//  Abbel-Cars
//
//  Created by a on 24/08/2020.
//  Copyright © 2020 Mian Faizan Nasir. All rights reserved.
//

import UIKit

extension UIButton
{
    func applyGradient(colors: [CGColor])
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func makeEnable(value : Bool)
    {
        self.isEnabled = value
        if value {
            self.alpha = 1
        } else {
            self.alpha = 0.5
        }
        
    }
    
    func makeEnableForContactsScreen(value : Bool)
    {
        self.isEnabled = value
        if value {
            self.backgroundColor = UIColor.appColor
            self.titleLabel?.textColor = UIColor.white
        } else {
            self.backgroundColor = UIColor(hexString: "DADADA")
            self.titleLabel?.textColor = UIColor(hexString: "A09F9F")
        }
    }
}
