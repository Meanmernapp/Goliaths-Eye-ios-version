//
//  BaseTableViewCell.swift
//  Waste2x
//
//  Created by HaiDer's Macbook Pro on 14/06/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import UIKit
import SDWebImage

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    func dateCalculate(date:String) -> String{
        var DateForConvert = date
        //APi date
        if let dotRange = date.range(of: "T") {
            DateForConvert.removeSubrange(dotRange.lowerBound..<DateForConvert.endIndex)
        }
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy"

        let date: NSDate? = dateFormatterGet.date(from: DateForConvert) as NSDate?
        return dateFormatterPrint.string(from: date! as Date)
}
    
}
