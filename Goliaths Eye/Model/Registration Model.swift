//
//  Registration.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 11/08/2022.
//

import Foundation
import ObjectMapper

typealias RegistrationCompletionHandler = (_ data: RegistrationModel?, _ error: Error?, _ status: Bool?, _ message:String) -> Void

class RegistrationModel : Mappable {
    
    var isError = Bool()
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        isError <- map["isError"]
    }
    
    class func registration(email: String,password:String,name:String,phone:String, _ completion: @escaping RegistrationCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.registration(email: email, password: password, name: name, phoneNumber: phone) { result, error, statusCode, messsage in
            Utility.hideLoading()
            completion(nil, error, statusCode,messsage)
        }

    }
    
}
