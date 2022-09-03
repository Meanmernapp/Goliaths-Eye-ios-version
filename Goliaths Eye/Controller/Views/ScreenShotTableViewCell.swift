//
//  ScreenShotTableViewCell.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 19/08/2022.
//

import UIKit

class ScreenShotTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    var uploadVideo : ((Data,String,Bool)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(data:UserScreenShotData?,index:Int) {
        self.nameLbl.text = "Screenshot-\(index+1)"
        let commingName = data?.imagePath?.split(separator: "-")
        let unixWithExtention = commingName?.last?.split(separator: ".")
        let unix = TimeInterval(unixWithExtention?.first ?? "0") ?? 0.0
        let date = Date(timeIntervalSince1970: unix/1000)
        self.timeLbl.text = date.dateToString("HH:mm:ss")
        self.dateLbl.text = date.dateToString("yyyy-MM-dd")
        self.uploadVideo = { e,u,p in
            
        }
        
    }
}
