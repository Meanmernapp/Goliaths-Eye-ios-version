//
//  AppDelegate.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 10/08/2022.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate,UISceneDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        let nav = UINavigationController()
        
        if DataManager.shared.getUser() != nil {
            let vc:HomeViewController = UIStoryboard.controller(storyboardName: "Main")
            nav.navigationBar.isHidden = true
            nav.viewControllers = [vc]
        }
        else {
            let vc:LogInViewController = UIStoryboard.controller(storyboardName: "Main")
            nav.viewControllers = [vc]
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        let connectionManager = ConnectionManager.shared
        connectionManager.startMonitoring()
        return true
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Goliaths_Eye")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

