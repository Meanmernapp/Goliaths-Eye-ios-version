//
//  UIViewController.swift
//  Abbel-Cars
//
//  Created by a on 27/08/2020.
//  Copyright © 2020 Mian Faizan Nasir. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: {
        })
    }
}
