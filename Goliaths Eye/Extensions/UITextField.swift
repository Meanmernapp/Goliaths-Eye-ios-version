//
//  UITextField.swift
//  ShaeFoodDairy
//
//  Created by Mac on 17/03/2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

extension UITextField {
    var substituteFontName : String {
        get { return self.font!.fontName }
        set { self.font = UIFont(name: newValue, size: (self.font?.pointSize)!) }
    }
    
    public enum Direction {
        case Left
        case Right
    }

    func addImage(direction:Direction, imageName:String, Frame:CGRect) {
        let View = UIView(frame: Frame)
        let imageView = UIImageView(frame: Frame)
        imageView.image = UIImage(named: imageName)
        View.addSubview(imageView)

        if Direction.Left == direction
        {
            self.leftViewMode = .always
            self.leftView = View
        }
        else
        {
            self.rightViewMode = .always
            self.rightView = View
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
