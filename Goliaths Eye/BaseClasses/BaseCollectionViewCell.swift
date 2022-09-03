//
//  BaseCollectionViewCell.swift
//  Waste2x
//
//  Created by HaiDer's Macbook Pro on 14/06/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import UIKit
import SDWebImage
class BaseCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        
    }
    
    func setImage(imageView:UIImageView,url:URL,placeHolder : String = "dummy")  {
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_imageIndicator?.startAnimatingIndicator()
        
        imageView.sd_setImage(with: url) { (img, err, cahce, URI) in
            imageView.sd_imageIndicator?.stopAnimatingIndicator()
            if err == nil{
                imageView.image = img
            }else{
                imageView.image = UIImage(named: placeHolder)
            }
        }
    }
}
