//
//  RegistrationViewController.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 11/08/2022.
//

import UIKit

class RegistrationViewController: BaseViewController {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var confirmPasswordLbl: UILabel!
    @IBOutlet weak var signInstack: UIStackView!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var signupLbl: UILabel!
    
    
    //MARK: - Variables
    
    var isViewProfile = false
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isViewProfile {
            if let data = DataManager.shared.getUser() {
                emailTF.placeholder = data.email
                nameTF.placeholder = data.name
                phoneTF.placeholder = data.phoneNumber
                emailTF.isEnabled = false
                nameTF.isEnabled = false
                phoneTF.isEnabled = false
                passwordTF.isHidden = true
                confirmPasswordLbl.isHidden = true
                signInstack.isHidden = true
                signUpBtn.isHidden = true
                passwordLbl.isHidden = true
                confirmPasswordTF.isHidden = true
                backBtn.isHidden = false
                signupLbl.text = "Profile"
            }
            
        }
        
    }
    
    
    
    //MARK: - IBAction
    
    
    @IBAction func loginAction(_ sender: Any) {
        if emailTF.text != "" {
            if passwordTF.text != "" && confirmPasswordTF.text != "" {
                if nameTF.text != "" {
                    if phoneTF.text != "" {
                        if emailTF.isValidEmail(emailTF.text!) {
                            if confirmPasswordTF.text == passwordTF.text {
                                RegistrationModel.registration(email: emailTF.text!, password: passwordTF.text!, name: nameTF.text!, phone: phoneTF.text!) { data, error, status, message in
                                    if error == nil {
                                        let vc : VerificationViewController = UIStoryboard.controller(storyboardName: "Main")
                                        vc.email = self.emailTF.text!
                                        self.navigationController?.pushViewController(vc, animated: true)
                                        self.showToast(message: message)
                                    }
                                    else {
                                        self.showToast(message: message)
                                    }
                                }
                            }
                            else {
                                showToast(message: "Password not matched...")
                            }
                        }
                        else {
                            showToast(message: "Please enter valid email...")
                        }
                    }
                    else {
                        showToast(message: "Please phone name...")
                    }
                }
                else {
                    showToast(message: "Please enter name...")
                }
            }
            else {
                showToast(message: "Please enter password...")
            }
        }
        else {
            showToast(message: "Please enter email...")
        }
    }
    
    @IBAction func signInPageAction(_ sender: Any) {
        self.loginAction(self.emailTF.text!, self.passwordTF.text!)
    }
    
    @IBAction func alreadyHaveAccountAction(_ sender: Any) {
        
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
