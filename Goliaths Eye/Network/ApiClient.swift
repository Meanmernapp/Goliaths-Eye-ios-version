
import UIKit
import Alamofire
import ObjectMapper


class Connectivity {
    
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

enum Action:String {
    case LOGIN
    case LOGOUT
    case RECORDING_START
    case RECORDING_STOP
}

let APIClientDefaultTimeOut = 40.0

class APIClient: APIClientHandler {
    let headers = ["Content-Type": "application/json"]
    fileprivate var clientDateFormatter: DateFormatter
    var isConnectedToNetwork: Bool?
    
    static var shared: APIClient = {
        let baseURL = URL(fileURLWithPath: APIRoutes.baseUrl)
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = APIClientDefaultTimeOut
        
        let instance = APIClient(baseURL: baseURL, configuration: configuration)
        
        return instance
    }()
    
    // MARK: - init methods
    
    override init(baseURL: URL, configuration: URLSessionConfiguration, delegate: SessionDelegate = SessionDelegate(), serverTrustPolicyManager: ServerTrustPolicyManager? = nil) {
        clientDateFormatter = DateFormatter()
        
        super.init(baseURL: baseURL, configuration: configuration, delegate: delegate, serverTrustPolicyManager: serverTrustPolicyManager)
        
        //        clientDateFormatter.timeZone = NSTimeZone(name: "UTC")
        clientDateFormatter.dateFormat = "yyyy-MM-dd" // Change it to desired date format to be used in All Apis
    }
    
    
    // MARK: Helper methods
    
    func apiClientDateFormatter() -> DateFormatter {
        return clientDateFormatter.copy() as! DateFormatter
    }
    
    fileprivate func normalizeString(_ value: AnyObject?) -> String {
        return value == nil ? "" : value as! String
    }
    
    fileprivate func normalizeDate(_ date: Date?) -> String {
        return date == nil ? "" : clientDateFormatter.string(from: date!)
    }
    
    var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func getUrlFromParam(apiUrl: String, params: [String: AnyObject]) -> String {
        var url = apiUrl + "?"
        
        for (key, value) in params {
            url = url + key + "=" + "\(value)&"
        }
        url.removeLast()
        return url
    }
    
    // MARK: - Onboarding
    
    func login(email: String,password:String, _ completionBlock: @escaping APIClientCompletionHandler) {
        let params = ["email": email,"password":password] as [String:AnyObject]
        _ = sendRequest(APIRoutes.login , parameters: params as [String : AnyObject],httpMethod: .post , headers: headers, completionBlock: completionBlock)
    }
    
    
    func registration(email: String,password:String,name:String,phoneNumber:String, _ completionBlock: @escaping APIClientCompletionHandler) {
        let params = ["email": email,"password":password,"name":name,"phoneNumber":phoneNumber] as [String:AnyObject]
        _ = sendRequest(APIRoutes.registartion , parameters: params as [String : AnyObject],httpMethod: .post , headers: headers, completionBlock: completionBlock)
    }
    
    func verificationCode(email: String,code:Int, _ completionBlock: @escaping APIClientCompletionHandler) {
        _ = sendRequest(APIRoutes.verifyEmail + "?email=\(email)&code=\(code)" , parameters:nil,httpMethod: .get , headers: nil, completionBlock: completionBlock)
    }
    
    func forgetPassword(email: String, _ completionBlock: @escaping APIClientCompletionHandler) {
        let params = ["email": email] as [String:AnyObject]
        _ = sendRequest(APIRoutes.forgotPassword , parameters: params as [String : AnyObject],httpMethod: .post , headers: headers, completionBlock: completionBlock)
    }

    
    func postLogs(userID: Int,action:String,_ completionBlock: @escaping APIClientCompletionHandler) {
        let params = ["userId": userID,"action":action] as [String:AnyObject]
        _ = sendRequest(APIRoutes.logs, parameters: params,httpMethod: .post , headers: headers, completionBlock: completionBlock)
    }
    
    func sendInvite(email: String,adminID:Int,_ completionBlock: @escaping APIClientCompletionHandler) {
        let params = ["email": email,"adminId":adminID] as [String:AnyObject]
        _ = sendRequest(APIRoutes.sendInvite, parameters: params,httpMethod: .post , headers: headers, completionBlock: completionBlock)
    }
    
    func getInvites(adminID: Int,_ completionBlock: @escaping APIClientCompletionHandler) {
        _ = sendRequest(APIRoutes.invites + "?adminId=\(adminID)" , parameters:nil,httpMethod: .get , headers: nil, completionBlock: completionBlock)
    }
    
    func getLogs(userID: Int,_ completionBlock: @escaping APIClientCompletionHandler) {
        print(APIRoutes.baseUrl + APIRoutes.logs + "?userId=\(userID)")
        rawRequest(url:APIRoutes.baseUrl + APIRoutes.logs + "?userId=\(userID)", method: .get, parameters: nil, headers: nil, completionBlock: completionBlock)
    }
    
    func getScreenShots(userID: Int,_ completionBlock: @escaping APIClientCompletionHandler) {
        print(APIRoutes.baseUrl + APIRoutes.screenShot + "?userId=\(userID)")
        rawRequest(url:APIRoutes.baseUrl + APIRoutes.screenShot + "?userId=\(userID)", method: .get, parameters: nil, headers: nil, completionBlock: completionBlock)
    }
    
    func sendImages(userID: Int,base64:String,_ completionBlock: @escaping APIClientCompletionHandler) {
        let params = ["userId": userID,"base64ImageContent":"data:image/jpeg;base64,"+base64] as [String:AnyObject]
        _ = sendRequest(APIRoutes.screenShot, parameters: params,httpMethod: .post , headers: headers, completionBlock: completionBlock)
        
    }
    

}

