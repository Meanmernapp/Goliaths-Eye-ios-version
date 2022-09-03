//
//  LogInViewController.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 11/08/2022.
//

import UIKit
import ObjectMapper

class LogInViewController: BaseViewController {

    
    //MARK: - IBOutlets

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    //MARK: - Variables
    
    var email = ""
    var password = ""
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTF.text = email
        self.passwordTF.text = password
    }
    
    //MARK: - IBAction
    
    
    @IBAction func loginAction(_ sender: Any) {
        if ((emailTF.text?.isValidEmail) != nil && emailTF.text != "") {
            if passwordTF.text != "" {
                LoginModel.login(email:emailTF.text!, password: passwordTF.text!) { data, error, status, message in
                    if error == nil {
                        DataManager.shared.setUser(user: data?.toJSONString() ?? "")
                        let vc:HomeViewController = UIStoryboard.controller(storyboardName: "Main")
                        self.navigationController?.navigationBar.isHidden = true
                        self.navigationController?.setViewControllers([vc], animated: true)
                    }
                    else if message.contains("User is not active.") {
                        let vc:VerificationViewController = UIStoryboard.controller(storyboardName: "Main")
                        vc.email = self.emailTF.text!
                        self.navigationController?.setViewControllers([vc], animated: true)
                        self.showToast(message: message)
                    }
                    else {
                        self.showToast(message: message)
                    }
                    
                    
                }
            }
            else {
                showToast(message: "Please enter password...")
            }
        }
        else {
            showToast(message: "Please enter valid email...")
        }

    }
    
    @IBAction func registrationAction(_ sender: Any) {
        let vc: RegistrationViewController = UIStoryboard.controller(storyboardName: "Main")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgotAction(_ sender: Any) {
        let vc: ForgetPasswordViewController = UIStoryboard.controller()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
