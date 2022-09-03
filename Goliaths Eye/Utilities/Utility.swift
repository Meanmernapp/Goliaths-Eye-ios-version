//
//  Utility.swift
//  Audtix
//
//  Created by Bilal Saeed on 9/14/19.
//  Copyright © 2019 Bilal Saeed. All rights reserved.
//

import UIKit
//import NVActivityIndicatorView
import Alamofire

struct NetworkingConnection {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}

@objc class Utility: NSObject {
    
    var window: UIWindow?
    
    class func getAppDelegate() -> AppDelegate? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate
    }
    
    class func loginRootViewController () {
        let loginViewController = UIViewController()
        let navigationController = BaseNavigationViewController()
        navigationController.viewControllers = [loginViewController]
        kApplicationWindow = UIWindow(frame: UIScreen.main.bounds)
        kApplicationWindow?.rootViewController = navigationController
        kApplicationWindow?.makeKeyAndVisible()
    }
    
    class func homeViewController () {
        let slider = UIViewController()
        let navigationController = BaseNavigationViewController()
        navigationController.viewControllers = [slider]
        kApplicationWindow = UIWindow(frame: UIScreen.main.bounds)
        kApplicationWindow?.rootViewController = navigationController
        kApplicationWindow?.makeKeyAndVisible()
    }
    
    class func setupHomeAsRootViewController () {
        let slideMenuController = UIViewController()
        kApplicationWindow = UIWindow(frame: UIScreen.main.bounds)
        kApplicationWindow?.rootViewController = slideMenuController
        kApplicationWindow?.makeKeyAndVisible()
    }
    


    class func autoLogin() {
        
//        if DataManager.shared.getUser() == nil {
//            loginRootViewController()
//
//        } else {
//           setupHomeAsRootViewController()
//        }
    }
    
    class func setPlaceHolderTextColor (_ textField: UITextField, _ text: String, _ color: UIColor) {
        textField.attributedPlaceholder = NSAttributedString(string: text,
        attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    class func cornerRadiusPostioned (corners: CACornerMask, view: UIView, cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.layer.maskedCorners = corners
        view.clipsToBounds = true
        view.layoutIfNeeded()
    }
    
    class func changeFontSizeRange (mainString: String, stringToChange: String) ->  NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: 11)
        let range = (mainString as NSString).range(of: stringToChange)
        
        let attribute = NSMutableAttributedString.init(string: mainString)
        attribute.addAttribute(NSAttributedString.Key.font, value: font , range: range)
        return attribute
    }
    
    class func changeFontStyleToBold (mainString: String, stringToChange: String) ->  NSMutableAttributedString {
        let font = UIFont(name: "SFProText-Bold", size: 15)!
        let range = (mainString as NSString).range(of: stringToChange)
        
        let attribute = NSMutableAttributedString.init(string: mainString)
        attribute.addAttribute(NSAttributedString.Key.font, value: font , range: range)
        return attribute
    }
    
    class func addTextFieldLeftViewImage(_ textField: UITextField, image: UIImage, width: Int, height: Int, leftPadding: Int, topPadding: Int) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width + leftPadding + 5, height: height + topPadding))
        let imageView = UIImageView(frame: CGRect(x: leftPadding, y: topPadding, width: width, height: height))
        imageView.image = image
        view.addSubview(imageView)
        
        textField.leftViewMode = .always
        textField.leftView = view
    }
    
    class  func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    static func isValidPhoneNumber(_ testStr:String) -> Bool {
        let emailRegEx = "^(\\d){10}$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func getScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    class func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    class func showAlertController (_ controller: UIViewController,_ message: String) {
        let easyVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
        easyVC.modalPresentationStyle = .overCurrentContext
        easyVC.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        controller.present(easyVC, animated: true, completion: nil)
    }
    
    class func hasTopNotch() -> Bool {
        
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        
        return false
    }
    
    class func makeBlurImage(targetImageView:UIImageView?, alpha: CGFloat = 1) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetImageView!.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        blurEffectView.alpha = alpha
        targetImageView?.addSubview(blurEffectView)
    }
    
    class func removeBlurFromImage(targetImageView: UIImageView?) {
        
        let blurViews = targetImageView?.subviews.filter({ (view) -> Bool in
            view.isKind(of: UIVisualEffectView.self)
        })
        
        blurViews?.forEach({ (view) in
            view.removeFromSuperview()
        })
    }
    @objc class func showLoading(offSet: CGFloat = 0, isVisible: Bool = true) {
        DispatchQueue.main.async {
            if let _ = kApplicationWindow?.viewWithTag(9000) {
                return
            }

            let superView = UIView(frame: CGRect(x: 0, y: 0 - offSet, width: kApplicationWindow?.frame.width ?? 0.0, height: kApplicationWindow?.frame.height ?? 0.0))
            let iconImageView = UIImageView(frame: CGRect(x: superView.frame.width/2 - 32.5, y: superView.frame.height/2 - 32.5, width: 65, height: 65))
            iconImageView.image = UIImage(named: "loading")
            
            if isVisible {
                superView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            
            } else {
                superView.backgroundColor = .clear
            }
            
            superView.tag = 9000
            iconImageView.rotate()
            superView.addSubview(iconImageView)
            superView.bringSubviewToFront(iconImageView)
            kApplicationWindow?.addSubview(superView)
        }

        }
    
    @objc class func hideLoading() {
        if let activityView = kApplicationWindow?.viewWithTag(9000) {
            activityView.removeFromSuperview()
        }
    }
    
    class func simpleDate (date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    
    
    class func changeDateFormate (dataInString : String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let localDate = dateFormatter.date(from: dataInString)
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MMM dd, yyyy"
        if localDate != nil {
            return dateFormatter.string(from: localDate!)
            
        } else {
            return ""
        }
    }
    
    class func dataInEnglish (_ dataInString : String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let localDate = dateFormatter.date(from: dataInString)
        
        let calendar = Calendar.current
        
        if localDate != nil {
            
            if calendar.isDateInYesterday(localDate!) {
                return "Yesterday"
            } else if calendar.isDateInToday(localDate!) {
                return "Today"
            } else {
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                dateFormatter.dateFormat = "MMM dd, yyyy"
                if localDate != nil {
                    return dateFormatter.string(from: localDate!)
                    
                } else {
                    return ""
                }
            }
        }
        return ""
    }
    
    
    class func isTextFieldHasText(textField: UITextField) -> Bool {
        if textField.hasText
        {
            return !isBlankString(text: textField.text!)
        }
        return false
    }
        
    class func isBlankString(text: String) -> Bool {
        let trimmed = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    
    class func isConnectedToNetwork() -> Bool {
        
        let bConnected : Bool?
        let manager = NetworkReachabilityManager(host: "www.apple.com")
        if (manager?.isReachable)!
        {
            manager?.listener = { status in
                print("Network Status Changed: \(status)")
            }
            bConnected = true
        }
        else {
            print("Network Status offline")
            bConnected = false
        }
        manager?.startListening()
        return bConnected!
    }
    
    class func DictToJsonString(_ dict : [String : Any]) -> String?
    {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) else {return nil}
        let decoded = String(data: jsonData, encoding: .utf8)!
        return decoded
    }
    
}
extension UIImageView {
    
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi / 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
