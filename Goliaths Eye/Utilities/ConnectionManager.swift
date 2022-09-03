//
//  ConnectionManager.swift
//  EasyGift
//
//  Created by Asad Mehmood on 20/12/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Network
import UIKit
import SystemConfiguration

final class ConnectionManager {
    
    static let shared = ConnectionManager()
    
    private let queue = DispatchQueue(label: "Monitor")
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = (path.status == .satisfied)
            
            if let connected = self?.isConnected {
                if connected {
                    DispatchQueue.main.async {
                        if let topController = UIApplication.topViewController() {
                            if topController is NoNetworkViewController {
                                if let networkController = topController as? NoNetworkViewController {
                                    if let navController = networkController.navigationController {
                                        navController.popViewController(animated: true)
                                    }
                                    else {
                                        networkController.dismiss(animated: true, completion: nil)
                                    }
                                }
                            }
                        }
                    }
                }
                else {
                    DispatchQueue.main.async {
                        if let topController = UIApplication.topViewController() {
                            if !(topController is NoNetworkViewController) {
                            
                                if let navController = UIApplication.topViewController()?.navigationController {
                                    navController.pushViewController(NoNetworkViewController(), animated: true)
                                }
                                else {
                                    let noNetworkScreen = NoNetworkViewController()
                                    noNetworkScreen.modalPresentationStyle = .fullScreen
                                    UIApplication.topViewController()?.present(noNetworkScreen, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    public func stop() {
        monitor.cancel()
    }
    
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

public class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
}
