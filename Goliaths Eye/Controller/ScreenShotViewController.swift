//
//  ScreenShotViewController.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 17/08/2022.
//

import UIKit

class ScreenShotViewController: BaseViewController {
    
    
    //MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notFoundLbl: UILabel!
    
    

    
    //MARK: - Variables
    
    
    var invitedUserID : Int?
    var userScreenShots : [UserScreenShotData]?
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getScreenShots()
    }
    
    
    
    //MARK: - IBAction
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - Functions
    
    func getScreenShots() {
        if let invitedUserID = invitedUserID {
            Logs.getScreenShots(userId: invitedUserID) { data, error, status, message in
                if error == nil {
                    self.userScreenShots = data
                    self.tableView.reloadData()
                }
                else {
                    if message.count > 0 {
                        self.showToast(message: message )
                    }
                    else {
                        self.showToast(message: "Check your internet")
                    }
                    
                }
                
            }
        }
    }
    func hide() {
        self.tableView.isHidden = true
        self.notFoundLbl.isHidden = false
    }
    
    func show() {
        self.tableView.isHidden = false
        self.notFoundLbl.isHidden = true
    }
    
}

extension ScreenShotViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userScreenShots?.count ?? 0 > 0 {
            show()
        }
        else {
            hide()
        }
        return userScreenShots?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.register(ScreenShotTableViewCell.self, indexPath: indexPath)
        cell.selectionStyle = .none
        cell.config(data: self.userScreenShots?[indexPath.row], index: indexPath.row)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc:PreviewViewController = UIStoryboard.controller()
        vc.userScreenShots = self.userScreenShots
        vc.index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


