//
//  MovePopUpViewController.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 24/08/2022.
//

import UIKit

protocol getResponseBack {
    func response(action:Bool,isFromLogs:Bool)
}

class MovePopUpViewController: BaseViewController {

    
    //MARK: - IBOutlets

    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var popUpView: UIView!
    
    
    //MARK: - Variables
    
    var delegate : getResponseBack?
    var isFromLog = false
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFromLog {
            self.topLbl.text = "LOGS"
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupDidappear()
    }
    
    
    //MARK: - IBAction
    
    
    @IBAction func hideAction(_ sender: Any) {
        delegate?.response(action: false, isFromLogs: isFromLog)
        hidePopup()
    }
    
    @IBAction func yesAction(_ sender: Any) {
        delegate?.response(action: true, isFromLogs: isFromLog)
        hidePopup()
    }
    
    @IBAction func laterAction(_ sender: Any) {
        delegate?.response(action: false, isFromLogs: isFromLog)
        hidePopup()
    }
    
    
    //MARK: - Functions
    
    func hidePopup() {
        popUpView.alpha = 1
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            
            self.popUpView.alpha = 0
            self.popUpView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
        }) { (success) in
            
            self.dismiss(animated: false, completion: nil)
            
        }
    }
    
    func setupDidappear() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [],  animations: {
            
            self.popUpView.transform = .identity
        })
        
    }
    
}
