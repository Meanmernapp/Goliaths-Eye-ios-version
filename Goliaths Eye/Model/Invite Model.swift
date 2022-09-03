//
//  Invite Model.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 18/08/2022.
//

import Foundation
import ObjectMapper
typealias InvitesCompletionHandler = (_ data: [InvitesData]?, _ error: Error?, _ status: Bool?, _ message:String) -> Void

class Invites : Mappable {
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        
    }
    
    class func getInvites(adminId:Int, _ completion: @escaping InvitesCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.getInvites(adminID: adminId) { result, error, statusCode, messsage in
            Utility.hideLoading()
            if error == nil {
                if messsage == "No invites found for this user" {
                    completion(nil,error,statusCode,messsage)
                } else {
                    let data = Mapper<InvitesData>().mapArray(JSONArray: result as! [[String:Any]])
                    completion(data,error,statusCode,messsage)
                }
            }
            else {
                completion(nil,error,statusCode,messsage)
            }

           
        }
        
    }
    class func sendInvite(email:String,adminId:Int, _ completion: @escaping LogsCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.sendInvite(email: email, adminID: adminId) { result, error, statusCode, messsage in
            Utility.hideLoading()
            completion(nil,error,statusCode,messsage)
        }
        
    }
    
}
class InvitesData : Mappable {
    
    var id : Int?
    var adminId : Int?
    var userEmail : String?
    var status : String?
    var inviteStatus : String?
    var password : String?
    var isActive : Bool?
    var isAdmin : Bool?
    var createdAt : String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        adminId <- map["adminId"]
        status <- map["status"]
        inviteStatus <- map["inviteStatus"]
        userEmail <- map["userEmail"]
    }
}

