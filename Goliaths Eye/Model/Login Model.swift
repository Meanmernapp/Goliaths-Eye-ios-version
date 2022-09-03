//
//  LoginModel.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 11/08/2022.
//

import Foundation
import ObjectMapper

typealias loginCompletionHandler = (_ data: LoginData?, _ error: Error?, _ status: Bool?, _ message:String) -> Void

typealias verificationCompletionHandler = (_ data: AnyObject?, _ error: Error?, _ status: Bool?, _ message:String) -> Void

class LoginModel : Mappable {
    
    
    var result = [LoginData]()
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        result <- map["data"]
    }
    
    class func login(email: String,password:String, _ completion: @escaping loginCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.login(email: email, password: password) { result, error, statusCode, messsage in
            Utility.hideLoading()
            if error == nil {
                if let data = Mapper<LoginData>().map(JSON: result as! [String : Any]) {
                    completion(data, nil, statusCode,messsage)
                } else {
                    completion(nil, nil, statusCode,messsage)
                }

            } else {
                 completion(nil, error, statusCode,messsage)
            }
        }

    }
    class func verification(email: String,code:Int, _ completion: @escaping verificationCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.verificationCode(email: email, code: code) { result, error, statusCode, messsage in
            Utility.hideLoading()
            if error == nil {
                completion(result,error,statusCode,messsage)
                
            }else {
                completion(nil,error,statusCode,messsage)
            }
        }

    }
    
}

class LoginData : Mappable {
    
    var id : Int?
    var name : String?
    var email : String?
    var secret : String?
    var phoneNumber : String?
    var password : String?
    var isActive : Bool?
    var isAdmin : Bool?
    var adminId : Int?
    var createdAt : String?

    required init?(map: Map) { }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        secret <- map["secret"]
        phoneNumber <- map["phoneNumber"]
        password <- map["password"]
        isActive <- map["isActive"]
        createdAt <- map["createdAt"]
        isAdmin <- map["isAdmin"]
        adminId <- map["adminId"]
    }
}
