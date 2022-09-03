//
//  HomeViewController.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 11/08/2022.
//

import UIKit
import WebBrowser
import WebKit

class HomeViewController: BaseViewController, getResponseBack {
    func response(action: Bool, isFromLogs: Bool) {
        if action {
            let vc: LogsViewController = UIStoryboard.controller()
            if !isFromLogs {
                vc.isForScreenShot = true
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    
    
    //MARK: - Variables
    
    var timeIntervalCount = 10.0
    var newImage = UIImage()
    var webView : WebBrowserViewController?
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var status: UILabel!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userStatus(check: "LOGIN")
        let simple = NSAttributedString(string: "Status :", attributes: [.foregroundColor:UIColor.white])
        let modifiedAttr = NSAttributedString(string: "Decline", attributes: [.foregroundColor:UIColor.red])
        let AccpetedAttr = NSAttributedString(string: "Accepted", attributes: [.foregroundColor:UIColor.systemGreen])
        self.status.attributedText = modifiedAttr
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK: - IBAction
    
    
    @IBAction func adminAction(_ sender: Any) {
        let vc = MovePopUpViewController(nibName: "MovePopUpViewController", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        self.webBrowser()
        self.userStatus(check: "RECORDING_START")
        self.showToast(message: "Recording Start")
        self.timer = Timer.scheduledTimer(timeInterval: timeIntervalCount,
                                          target: self,
                                          selector: #selector(self.update),
                                          userInfo: nil,
                                          repeats: true)
        
    }
    
    @IBAction func viewProfile(_ sender: Any) {
        let vc:RegistrationViewController = UIStoryboard.controller()
        vc.isViewProfile  = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logAction(_ sender: Any) {
        let vc = MovePopUpViewController(nibName: "MovePopUpViewController", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        vc.isFromLog = true
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func registerEmailAction(_ sender: Any) {
        let vc : InviteViewController  = UIStoryboard.controller()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        self.userStatus(check: "LOGOUT")
        self.timer?.invalidate()
        self.timer = nil
        DataManager.shared.deleteUser()
        self.loginAction()
        
    }
    
    
    
    //MARK: - Functions
    
    @objc func update() {
        let screenShot = self.screenShotMethod(view: self.webView ?? self)
        let base64 = self.imageToBase64(image: screenShot)
        Logs.postScreenShots(userId: self.USERID, base64: base64) { data, error, status, message in
            if error != nil {
                self.showToast(message: error?.localizedDescription ?? "Try again later")
            }
        }
    }
    
    func webBrowser() {
        let webBrowserViewController = WebBrowserViewController()
        
        webBrowserViewController.delegate = self
        webBrowserViewController.language = .english
        webBrowserViewController.tintColor = .white
        webBrowserViewController.barTintColor = .black
        webBrowserViewController.isToolbarHidden = false
        webBrowserViewController.isShowActionBarButton = true
        webBrowserViewController.toolbarItemSpace = 50
        webBrowserViewController.isShowURLInNavigationBarWhenLoading = true
        webBrowserViewController.isShowPageTitleInNavigationBar = true
        webBrowserViewController.loadURLString("https://www.google.com/")
        self.webView = webBrowserViewController
        let navigationWebBrowser = WebBrowserViewController.rootNavigationWebBrowser(webBrowser: webBrowserViewController)
        navigationWebBrowser.modalPresentationStyle = .fullScreen
        present(navigationWebBrowser, animated: true, completion: nil)
        
    }
    
}


extension HomeViewController: WebBrowserDelegate {
    func webBrowser(_ webBrowser: WebBrowserViewController, didStartLoad url: URL?) {
        
    }
    
    func webBrowser(_ webBrowser: WebBrowserViewController, didFinishLoad url: URL?) {
        
    }
    
    func webBrowser(_ webBrowser: WebBrowserViewController, didFailLoad url: URL?, withError error: Error) {
        
    }
    
    func webBrowserWillDismiss(_ webBrowser: WebBrowserViewController) {
        self.timer?.invalidate()
        self.timer = nil
        self.userStatus(check: "RECORDING_STOP")
        self.showToast(message: "Recording Stop")
    }
    
    func webBrowserDidDismiss(_ webBrowser: WebBrowserViewController) {
        
    }
    
    func webBrowser(_ webBrowser: WebBrowserViewController, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) -> Bool {
        false
    }
}
