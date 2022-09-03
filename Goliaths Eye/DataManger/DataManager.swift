//
//  DataManager.swift
//  Haid3r
//
//  Created by a on 27/10/2020.
//  Copyright © 2020 Haider Awan. All rights reserved.
//

import Foundation
import ObjectMapper

class DataManager {
    
    static let shared = DataManager()


    
    //MARK: - Users Data
    
    func setUser (user: String) {
        UserDefaults.standard.set(user, forKey: "user_data")
    }
    
    func getUser() -> LoginData? {
        
        var user: LoginData?
        if UserDefaults.standard.object(forKey: "user_data") != nil {
            user = Mapper<LoginData>().map(JSONString:UserDefaults.standard.string(forKey: "user_data")!)
        }
        return user
    }
    
    func deleteUser () {
         UserDefaults.standard.set(nil, forKey: "user_data")
    }
    
}
