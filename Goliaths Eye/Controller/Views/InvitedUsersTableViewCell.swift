//
//  InvitedUsersTableViewCell.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 18/08/2022.
//

import UIKit

enum Status:String {

    case ACCEPTED
    case REJECTED
    case INSTALLED
    case PENDING
}

class InvitedUsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var rawView: UIView!
    @IBOutlet weak var statusLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func config(email:String?,status:String? = "ADMIN") {
        rawView.isHidden = true
        if email == DataManager.shared.getUser()?.email {
            self.emailLbl.textColor = .red
            self.emailLbl.text = "Self: \(email ?? "")"
            self.statusLbl.text = status
        }
        else {
            self.emailLbl.textColor = UIColor.init(hexString: "514E98")
            self.emailLbl.text = "Email: \(email ?? "")"
            if Status.PENDING.rawValue == status {
                self.rawView.backgroundColor = .systemOrange
                self.statusLbl.textColor = .systemOrange
            }
            else if Status.REJECTED.rawValue == status {
                self.rawView.backgroundColor = .systemRed
                self.statusLbl.textColor = .systemRed
            }
            else if Status.ACCEPTED.rawValue == status {
                self.rawView.backgroundColor = .systemGreen
                self.statusLbl.textColor = .systemGreen
            }
            else {
                self.rawView.backgroundColor = .systemGreen
                self.statusLbl.textColor = .systemGreen
            }
            self.statusLbl.text = status
        }
    }
    
}
