//
//  OtherUsersLogViewController.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 19/08/2022.
//

import UIKit

class OtherUsersLogViewController: BaseViewController {
    
    
    //MARK: - Variables
    
    var invitedUserID : Int?
    var userLogs : [UserLogsData]?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logsLbl: UILabel!
    
    //MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getLogs()
        
    }
    
    
    
    //MARK: - IBAction
    
    
    //MARK: - Functions
    
    func getLogs() {
        if let invitedUserID = invitedUserID {
            Logs.getLogs(userId: invitedUserID) { data, error, status, message in
                if error == nil {
                    
                    self.userLogs = data
                    self.tableView.reloadData()
                }
                else {
                    self.showToast(message: "Check your internet")
                }
            }
        }
    }
    
    func hide() {
        self.tableView.isHidden = true
        self.logsLbl.isHidden = false
    }
    
    func show() {
        self.tableView.isHidden = false
        self.logsLbl.isHidden = true
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension OtherUsersLogViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userLogs?.count ?? 0 > 0 {
            self.show()
        }
        else {
            self.hide()
        }
        return self.userLogs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.register(LogsTableViewCell.self, indexPath: indexPath)
        cell.config(data: self.userLogs?[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderView.instanceFromNib()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


