//
//  Extentions.swift
//  ContainerView
//
//  Created by HaiD3R AwaN on 13/04/2021.
//

import UIKit


//MARK: - StoryBoard Reference
extension UIStoryboard {
    
    class func controller  <T: UIViewController> (storyboardName : String = "Main") -> T {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: T.className) as! T
    }
}


//MARK: - NSObject
extension NSObject {
    class var className: String {
        return String(describing: self.self)
    }
}




//MARK: - TableView
extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }


    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
}

extension Double {
    var shortValue: String {
        return String(format: "%.0f", self)
    }
}
extension Date {
    func returnDate()->String{
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd"
//        formatter.locale = NSLocale(localeIdentifier: "UTC") as Locale
        return formatter.string(from: self) 
    }
    func returnTime()->String{
        let formatter = DateFormatter.init()
        formatter.dateFormat = "HH:MM:ss"
//        formatter.locale = NSLocale(localeIdentifier: "UTC") as Locale
        return formatter.string(from: self)
    }
}
