//
//  BaseViewController.swift
//  haid3r
//
//  Created by HaiD3R AwaN on 20/05/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import UIKit
import SDWebImage

class BaseViewController: UIViewController {

    
    var USERID = 0
    var timer  : Timer?
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userId = DataManager.shared.getUser()?.id else {
            return
        }
        self.USERID = userId
        
    }
    func loginAction(_ email:String = "",_ password:String = "") {
        let vc: LogInViewController = UIStoryboard.controller(storyboardName: "Main")
        vc.email = email
        vc.password = password
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    func userStatus(check:String) {
        guard let userID = DataManager.shared.getUser()?.id else {self.showToast(message: "Login Again")
            self.loginAction()
            return
        }
        Logs.postLogs(userId: userID, logs: check) { data, error, status, message in
            if error == nil {
                self.showToast(message: message)
            }
            else {
                self.showToast(message: "Check your internet")
            }
        }
    }
    func screenShotMethod(view:UIViewController) -> UIImage {
        //Create the UIImage
        UIGraphicsBeginImageContext(view.view.frame.size)
        view.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
    func imageToBase64(image:UIImage) -> String {
        if let imageData = image.jpeg(.medium) {
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            return strBase64
        }
        else {
            let imageData:Data = image.pngData()!
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            return strBase64
        }
    }
    func base64ToImage(base64:String) -> UIImage? {
        let dataDecoded : Data = Data(base64Encoded: base64, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage ?? nil
    }
    

    /**************************************************/
    
    @objc func imageSelectedFromGalleryOrCamera(selectedImage:UIImage){
        
    }
    
    func setImage(imageView:UIImageView,url:URL,placeHolder : String = "dummy")  {
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_imageIndicator?.startAnimatingIndicator()
        imageView.sd_setImage(with: url) { (img, err, cahce, URI) in
            imageView.sd_imageIndicator?.stopAnimatingIndicator()
            if err == nil{
                imageView.image = img
            }else{
                imageView.image = UIImage(named: placeHolder)
            }
        }
    }
    func showToast(message : String, _ position: Double = ScreenSize.SCREEN_HEIGHT, _ lines:Double = 40) {
        let toastLabel = UILabel(frame: CGRect(x:ScreenSize.SCREEN_WIDTH/6 , y:position-100, width: ScreenSize.SCREEN_WIDTH/1.5, height: lines))
        toastLabel.backgroundColor = UIColor.appColor
        toastLabel.textColor = UIColor.white
        var font = UIFont()
        if let tempFont = UIFont(name: "Poppins-Regular", size: 13)
        {
            font = tempFont
        }
        else
        {
            font = UIFont.systemFont(ofSize: 13)
        }
        
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines  =  2
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

}
