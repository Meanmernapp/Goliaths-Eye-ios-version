//
//  HeaderView.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 19/08/2022.
//

import Foundation
import UIKit

class HeaderView: UIView {

    class func instanceFromNib() -> HeaderView {
        
        let view = UINib(nibName: "headerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! HeaderView
        
        return view
    
    }

}
