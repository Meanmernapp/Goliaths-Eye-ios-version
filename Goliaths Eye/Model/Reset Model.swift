//
//  Reset Model.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 16/08/2022.
//

import Foundation
import ObjectMapper

typealias ResetCompletionHandler = (_ data: ResetModel?, _ error: Error?, _ status: Bool?, _ message:String) -> Void

class ResetModel : Mappable {
    
    var isError = Bool()
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        isError <- map["isError"]
    }
    
    class func reset(email: String, _ completion: @escaping ResetCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.forgetPassword(email: email) { result, error, statusCode, messsage in
            completion(nil, error, statusCode, messsage)
        }

    }
    
}
