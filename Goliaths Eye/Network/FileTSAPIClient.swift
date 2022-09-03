
import UIKit
import Alamofire

typealias TSAPIClientCompletionBlock = (_ response: HTTPURLResponse?, _ result: AnyObject?, _ error: NSError?) -> Void

// MARK: -

class TSAPIClient: SessionManager {

    // MARK: - Properties methods

    fileprivate var serviceURL: URL?

    // MARK: - init & deinit methods

    init(baseURL: URL,
         configuration: URLSessionConfiguration = URLSessionConfiguration.default,
         delegate: SessionDelegate = SessionDelegate(),
         serverTrustPolicyManager: ServerTrustPolicyManager? = nil){

        super.init(configuration: configuration, delegate: delegate, serverTrustPolicyManager: serverTrustPolicyManager)

        var aURL = baseURL

        // Ensure terminal slash for baseURL path, so that NSURL relativeToURL works as expected

        if aURL.path.count > 0 && !aURL.absoluteString.hasSuffix("/") {
            aURL = baseURL.appendingPathComponent("")
        }

        serviceURL = baseURL
   //     NetworkActivityIndicatorManager.shared.isEnabled = true
    }

    // MARK: - Public methods

    func serverRequest(_ methodName: String, parameters: [String : AnyObject]? , httpMethod: HTTPMethod, headers: [String : String]?, completionBlock: @escaping TSAPIClientCompletionBlock) -> Request {
        let encodedMethodName = methodName.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let url = URL(string: encodedMethodName!, relativeTo: serviceURL)
        print("\(String(describing: url))")

    //    Utility.loadCookies()

        if httpMethod == .get {

            let request = self.request(url!, method: .get , parameters: parameters, encoding: URLEncoding.default, headers: headers)
                .validate(statusCode: 200..<600)
                .responseJSON { response in

                    switch response.result {

                    case .success:
                        self.showRequestDetailForSuccess(responseObject: response)
                        completionBlock(response.response, response.result.value as AnyObject?, nil)
                        break

                    case .failure(let error):
                        self.showRequestDetailForFailure(responseObject: response)
                        completionBlock(response.response, nil, error as NSError?)
                        break
                    }
            }

            return request

        } else {  // .post ||  .delete ||  .put
            return self.createHttpRequest(encodedMethodName!, url: url!, parameters: parameters, httpMethod: httpMethod, headers: headers, completionBlock: completionBlock)
        }
    }

    func createHttpRequest(_ methodName: String, url: URL, parameters: [String : AnyObject]? , httpMethod: HTTPMethod, headers: [String : String]?, completionBlock: @escaping TSAPIClientCompletionBlock) -> Request {

        let request = self.request(url, method: httpMethod , parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<600)
            .responseJSON { response in

                if methodName == "login" || methodName == "confirm/phone/verification/code" || methodName == "driver/logIn/validateVerificationCode" {
                  //  Utility.saveCookies(response: response)
                }

                switch response.result {

                case .success:
                    self.showRequestDetailForSuccess(responseObject: response)
                    completionBlock(response.response, response.result.value as AnyObject?, nil)
                    break

                case .failure(let error):
                    self.showRequestDetailForFailure(responseObject: response)
                    completionBlock(response.response, nil, error as NSError?)
                    break
                }
        }

        return request
    }

    func cancelAllRequests() {
        session.getAllTasks { tasks in

            for task in tasks {
                task.cancel()
            }
        }
    }

    func showRequestDetailForSuccess(responseObject response : DataResponse<Any>) {

        print("\n\n\n ✅ ✅ ✅ ✅ ✅  ------- Success Response Start -------  ✅ ✅ ✅ ✅ ✅ \n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)

        if let bodyData : Data = response.request?.httpBody {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            print("\n=========   Request httpBody   ========== \n" + bodyString!)

        } else {
            print("\n=========   Request httpBody   ========== \n" + "Found Request Body Nil")
        }

        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            print("\n=========   Response Body   ========== \n" + responseString!)

        } else {
            print("\n=========   Response Body   ========== \n" + "Found Response Body Nil")
        }

        print("\n\n\n ✅ ✅ ✅  ------- Success Response End -------  ✅ ✅ ✅ \n\n\n")

    }

    func showRequestDetailForFailure(responseObject response : DataResponse<Any>) {

        print("\n\n\n ❌ ❌ ❌ ❌ ❌ ------- Failure Response Start ------- ❌ ❌ ❌ ❌ ❌ \n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)

        if let bodyData : Data = response.request?.httpBody {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            print("\n=========   Request httpBody   ========== \n" + bodyString!)

        } else {
            print("\n=========   Request httpBody   ========== \n" + "Found Request Body Nil")
        }

        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            print("\n=========   Response Body   ========== \n" + responseString!)

        } else {
            print("\n=========   Response Body   ========== \n" + "Found Response Body Nil")
        }

        print("\n\n\n ❌ ❌ ❌ ------- Failure Response End ------- ❌ ❌ ❌ \n")

    }
}
