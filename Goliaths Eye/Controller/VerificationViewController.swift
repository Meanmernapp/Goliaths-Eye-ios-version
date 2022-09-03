//
//  VerificationViewController.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 12/08/2022.
//

import UIKit

class VerificationViewController: BaseViewController {

    @IBOutlet weak var codeTF: UITextField!
    var email = ""
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func confirmCode(_ sender: Any) {
        if codeTF.text?.count ?? 0 == 6 && codeTF.text != "" {
            let code : Int = Int(codeTF.text ?? "0") ?? 0
            if code != 0  {
                LoginModel.verification(email: email, code: code) { data, error, status, message in
                    if error == nil {
                        self.loginAction(self.email)
                        self.showToast(message: message)
                    }
                    else {
                        self.showToast(message: message)
                    }
                }
            }
        }
        else {
            showToast(message: "Please enter 6 digit code")
        }

    }
    
}
