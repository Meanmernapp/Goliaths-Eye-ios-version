//
//  LogsViewController.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 17/08/2022.
//

import UIKit

class LogsViewController: BaseViewController {
    
    
    //MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Variables
    
    var isForScreenShot = false
    var invitedUsers : [InvitesData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Invites.getInvites(adminId: USERID) { data, error, status, message in
            if data != nil {
                self.invitedUsers = data
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
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    

}
extension LogsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.invitedUsers?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.register(InvitedUsersTableViewCell.self, indexPath: indexPath)
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.config(email: DataManager.shared.getUser()?.email ?? "")
        }
        else {
            cell.config(email: self.invitedUsers?[indexPath.row-1].userEmail,status: self.invitedUsers?[indexPath.row-1].inviteStatus)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if isForScreenShot {
            let vc:ScreenShotViewController = UIStoryboard.controller()
            if indexPath.row == 0 {
                vc.invitedUserID = DataManager.shared.getUser()?.id ?? 0
            }
            else {
                vc.invitedUserID = self.invitedUsers?[indexPath.row-1].id
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc:OtherUsersLogViewController = UIStoryboard.controller()
            if indexPath.row == 0 {
                vc.invitedUserID = DataManager.shared.getUser()?.id ?? 0
            }
            else {
                vc.invitedUserID = self.invitedUsers?[indexPath.row-1].id
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}


