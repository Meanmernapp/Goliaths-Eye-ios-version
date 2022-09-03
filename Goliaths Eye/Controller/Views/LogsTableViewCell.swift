//
//  LogsTableViewCell.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 19/08/2022.
//

import UIKit

class LogsTableViewCell: UITableViewCell {

    @IBOutlet weak var logLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(data:UserLogsData?) {
        let splitedArray = data?.logTime?.split(separator: "T")
        var time = String(splitedArray?.last ?? "")
        time.removeLast()
        let date = String(splitedArray?.first ?? "")
        self.logLbl.text = data?.action
        self.timeLbl.text = String(time)
        self.dateLbl.text = String(date)
    }
    
}
