//
//  InviteViewController.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 19/08/2022.
//

import UIKit

class InviteViewController: BaseViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var headingLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func emailAction(_ sender: Any) {
        if ((emailTF.text?.isValidEmail) != nil && emailTF.text != "") {
            Invites.sendInvite(email: self.emailTF.text!, adminId: self.USERID) { data, error, status, message in
                if error == nil {
                    if status ?? false {
                        // FALSE
                        self.showToast(message: message)
                    }
                    else {
                        // TRUE
                        //self.headingLbl.text = "Invite more emails "
                        self.emailTF.text = ""
                        self.showToast(message: message)
                    }
                    
                }
                else {
                    self.showToast(message: "Check your internet")
                }
            }
            
        }
        else {
            self.showToast(message: "Please enter valid email...")
        }
        
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
