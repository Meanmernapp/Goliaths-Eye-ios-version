//
//  ForgetPasswordViewController.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 11/08/2022.
//

import UIKit

class ForgetPasswordViewController: BaseViewController {

    
    
    //MARK: - IBOutlets

    @IBOutlet weak var emailTF: UITextField!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //MARK: - IBAction
    
    
    @IBAction func sendEmailAction(_ sender: Any) {
        if emailTF.text != "" {
            if emailTF.isValidEmail(emailTF.text!) {
                ResetModel.reset(email: emailTF.text!) { data, error, status, message in
                    if error == nil {
                        self.showToast(message: message)
                        self.loginAction(self.emailTF.text!)
                    }
                    else {
                        self.showToast(message: message)
                    }
                    
                }
            }
            else {
                showToast(message: "Please enter valid email...")
            }
        }
        else {
            showToast(message: "Please enter email...")
        }
        
    }
    
    @IBAction func signInAction(_ sender: Any) {
        self.loginAction(emailTF.text!)
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let vc:RegistrationViewController = UIStoryboard.controller(storyboardName: "Main")
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
}
