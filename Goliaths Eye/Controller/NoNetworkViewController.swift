//
//  NoNetworkViewController.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 19/08/2022.
//

import UIKit

class NoNetworkViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tryAgainAction(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            self.navigationController?.popViewController(animated: true)
        }
        else {
            self.showToast(message: "Not Found")
        }
    }
    
    
    
}
