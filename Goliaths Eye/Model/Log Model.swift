//
//  Log Model.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 16/08/2022.
//

import Foundation
import ObjectMapper

typealias LogsCompletionHandler = (_ data: AnyObject?, _ error: Error?, _ status: Bool?, _ message:String) -> Void
typealias ScreenShotCompletionHandler = (_ data: [UserScreenShotData]?, _ error: Error?, _ status: Bool?, _ message:String) -> Void
typealias LogsGetCompletionHandler = (_ data: [UserLogsData]?, _ error: Error?, _ status: Bool?, _ message:String) -> Void

class Logs : Mappable {
    
    var isError = Bool()
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        isError <- map["isError"]
    }
    
    class func postLogs(userId:Int,logs: String, _ completion: @escaping LogsCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.postLogs(userID: userId, action: logs) { result, error, statusCode, messsage in
            
            Utility.hideLoading()
            if error == nil {
                completion(result,error,statusCode,messsage)
                
            }
            else {
                completion(nil,error,statusCode,messsage)
            }
        }
        
    }
    
    class func getLogs(userId:Int, _ completion: @escaping LogsGetCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.getLogs(userID: userId) { result, error, statusCode, messsage in
            Utility.hideLoading()
            if error == nil {
            let data = Mapper<UserLogsData>().mapArray(JSONArray: result as! [[String : Any]])
                completion(data,error,statusCode,messsage)
                
            }
            else {
                completion(nil,error,statusCode,messsage)
            }
            
        }
    }
    
    class func getScreenShots(userId:Int, _ completion: @escaping ScreenShotCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.getScreenShots(userID: userId) { result, error, statusCode, messsage in
            Utility.hideLoading()
            if error == nil {
                let data = Mapper<UserScreenShotData>().mapArray(JSONArray: result as! [[String : Any]])
                completion(data,error,statusCode,messsage)
            }
            else {
                completion(nil,error,statusCode,messsage)
            }

        }
    }
    
    class func postScreenShots(userId:Int,base64:String, _ completion: @escaping LogsCompletionHandler) {
        APIClient.shared.sendImages(userID: userId, base64: base64) { result, error, statusCode, messsage in
            if error == nil {
                completion(result,error,statusCode,messsage)
                
            }
            else {
                completion(nil,error,statusCode,messsage)
            }
        }
    }
}

class UserLogsData : Mappable {
    
    var action : String?
    var userId : Int?
    var userName : String?
    var logTime : String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        action <- map["action"]
        userId <- map["userId"]
        userName <- map["userName"]
        logTime <- map["logTime"]
    }
}

class UserScreenShotData : Mappable {
    
    var imagePath : String?
    var userId : Int?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        imagePath <- map["imagePath"]
        userId <- map["userId"]
    }
}
