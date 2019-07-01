//
//  NetworkManager.swift
//  TOYIN
//
//  Created by Mehul Parmar on 06/04/19.
//  Copyright © 2018 Demo Viper with API. All rights reserved.
//  LinkedIn: https://www.linkedin.com/in/mehul-p-20268539/

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper
import SVProgressHUD

class NetworkManager : NSObject {
    let baseUrlLive : String = "http://www.toyin.io/toyinapp/"
    
    //MARK : - Shared Manager
    let sharedManager = SessionManager()
    
    // MARK: - POST Method
    func POST(_ urlString: String, paramaters: [String: AnyObject]? = nil, showLoader: Bool? = nil, success:@escaping (_ responseObject:JSON) -> Void , failure:@escaping (_ errorResponse:JSON?) -> Void) {
        
        InternetManager.sharedInstance.isUnreachable { _ in
            if let _ = showLoader {
                UIApplication.shared.keyWindow?.makeToast(message: AppAlertMsg.kNoInternet, duration: 3.0, position: "bottom" as AnyObject)
            }
            failure(JSON(AppAlertMsg.kNoInternet))
            print("No internet")
        }
        
        if let showLoader = showLoader {
            if showLoader {
                DispatchQueue.main.async {
                    if !UIApplication.shared.isIgnoringInteractionEvents {
                        UIApplication.shared.beginIgnoringInteractionEvents()
                    }
                    SVProgressHUD.show(withStatus: AppAlertMsg.kPleaseWait)
                }
            }
        }
        
        sharedManager.request(baseUrlLive.add(urlString: urlString), method: .post, parameters: paramaters, encoding: URLEncoding.default, headers: getHeaders()).validate().responseJSON(completionHandler: { response in
            
            DispatchQueue.main.async {
                if UIApplication.shared.isIgnoringInteractionEvents {
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
                
                if let showLoader = showLoader {
                    if showLoader {
                        if SVProgressHUD.isVisible() {
                            SVProgressHUD.dismiss()
                        }
                    }
                }
            }
            
            //Success
            if response.result.isSuccess {
                if let value = response.result.value {
                    let dictResponce = self.isValidated(value as AnyObject)
                    
                    //Print response using below method
                    var headerDictionary = [String: String]()
                    if let headerDictionaryTemp = response.request?.allHTTPHeaderFields {
                        headerDictionary = headerDictionaryTemp
                    }
                    self.printResponse(urlString: urlString, allHTTPHeaderFields: headerDictionary, paramaters: paramaters, response: (value as AnyObject))
                    
                    if dictResponce.0 == true {
                        success(dictResponce.1)
                    }
                    else {
                        failure(dictResponce.1)
                    }
                }
            } else {
                // Print server log
                /*let dataString = String(data: response.data!, encoding: String.Encoding.utf8)
                 print(dataString ?? "server error")*/
                
                //Check response error using status code
                if let strErrorReasonCode : Int = response.response?.statusCode {
                    if let data = response.data {
                        /*
                         do{
                         //here dataResponse received from a network request
                         let jsonResponse = try JSONSerialization.jsonObject(with:
                         data, options: [])
                         print(jsonResponse) //Response result
                         } catch let parsingError {
                         print("Error", parsingError)
                         }*/
                        
                        if let jsonResponce = try? JSON(data: data) {
                            if strErrorReasonCode == 500 {
                                print("\n\n\n\n server error :\(AppAlertMsg.kErrorMsg) \n\n URL:\(urlString) \n\n paramaters:\(JSON(paramaters as Any))\n\n\n\n")
                                UIApplication.shared.keyWindow?.makeToast(message: AppAlertMsg.kErrorMsg, duration: 3.0, position: "bottom" as AnyObject)
                                failure(jsonResponce)
                                return
                            }
                            
                            //Print response using below method
                            var headerDictionary = [String: String]()
                            if let headerDictionaryTemp = response.request?.allHTTPHeaderFields {
                                headerDictionary = headerDictionaryTemp
                            }
                            
                            if let dictionary : NSDictionary = jsonResponce.dictionaryObject as NSDictionary? {
                                let authentication_Error = 401
                                let forbidden_Error = 403
                                let authentication_Errors_Range = 400..<500
                                let Alamofire_Error = -1005
                                
                                let message = dictionary.value(forKey: "message") ?? "Error in response, Please Try again"
                                print("Response Print:-\n_____________________\nauthentication_Errors_Range :\(strErrorReasonCode),\n\nurlString : \(urlString), \n\nallHTTPHeaderFields : \(headerDictionary), \n\nmessage: \(message as! String) \n\nparamaters: \(String(describing: paramaters)) \n\nresponse: \(jsonResponce)\n\n")
                                
                                if forbidden_Error == strErrorReasonCode {
                                    success(JSON(dictionary))
                                }
                                else if authentication_Error == strErrorReasonCode {
                                    self.isUnAuthotized(message as! String)
                                    failure(jsonResponce)
                                }
                                else if authentication_Errors_Range.contains(strErrorReasonCode) {
                                    CustomAlert().ShowAlert(message as! String)
                                    failure(jsonResponce)
                                }
                                else if authentication_Errors_Range.contains(Alamofire_Error) {
                                    self.POST(urlString, paramaters: paramaters, showLoader: showLoader, success: { (responseObject) in
                                        if response.result.isSuccess {
                                            if let value = response.result.value {
                                                let dictResponce = self.isValidated(value as AnyObject)
                                                if dictResponce.0 == true {
                                                    success(dictResponce.1)
                                                }
                                                else {
                                                    failure(dictResponce.1)
                                                }
                                            }
                                        }
                                    }, failure: {_ in
                                        failure(jsonResponce)
                                    })
                                }
                            }
                            else {
                                print("\n\n\n\n server error :\(AppAlertMsg.kErrorMsg) \n\n URL:\(urlString) \n\n paramaters:\(JSON(paramaters as Any))\n\n\n\n")
                                UIApplication.shared.keyWindow?.makeToast(message: AppAlertMsg.kErrorMsg, duration: 3.0, position: "bottom" as AnyObject)
                                failure(jsonResponce)
                            }
                        }
                    }
                }
                else {
                    failure(nil)
                }
            }
        })
    }
}

extension NetworkManager {
    func isUnAuthotized(_ message: String) {
        // we have to logout, bcos session expired , or user unauthorized
        CustomAlert().ShowAlert(isCancelButton: false, strMessage: message) { _ in
        }
    }
    
    func isValidated(_ response: AnyObject?) -> (Bool, JSON) {
        //Removing null and <null>, and replacing number or integer to string
        guard var dictResponse = response as? NSDictionary else{
            return (false,JSON.null)
        }
        
        dictResponse = (dictResponse.replacingNullsWithStrings() as NSDictionary).convertingNumbersToStrings()! as NSDictionary
        let jsonResponce = JSON(dictResponse)
        return (true, jsonResponce)
    }
    
    // MARK: - Check Status
    func removeNullFromNSDictionary(_ dictResponse: NSDictionary) -> NSDictionary {
        return (dictResponse.replacingNullsWithStrings() as NSDictionary).convertingNumbersToStrings()! as NSDictionary
    }
    
    // MARK: - Loader method
    class func ShowActivityIndicatorInStatusBar() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
    class func HideActivityIndicatorInStatusBar() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    func printResponse(urlString: String, allHTTPHeaderFields: [String: String], paramaters: [String: AnyObject]?, response: AnyObject) {
        
        let dictResponce = self.getValidatedData(response as AnyObject)
        //        return
        //        if dictResponce.boolValue {
        if let paramatersTemp = paramaters {
            if paramatersTemp.values.count > 0 {
                let jsonParameters = JSON(paramatersTemp)
                print("\n\n\nurlString : \(urlString), \n\n\nallHTTPHeaderFields : \(allHTTPHeaderFields) ,\n\n paramaters: \(jsonParameters) ,\n\n Response: \(String(describing: dictResponce))\n\n\n")
            }
            else {
                print("\n\n\nurlString : \(urlString) , \n\n\nallHTTPHeaderFields : \(allHTTPHeaderFields),\n\n Response: \(String(describing: dictResponce))\n\n\n")
            }
        }
        else {
            print("\n\n\nurlString : \(urlString) , \n\n\nallHTTPHeaderFields : \(allHTTPHeaderFields) ,\n\n Response: \(String(describing: dictResponce))\n\n\n")
        }
        //        } else {
        //            print("urlString : \(urlString) ,\n Response: \(String(describing: dictResponce))")
        //        }
    }
    
    func getValidatedData(_ response: AnyObject?) -> JSON {
        
        //Removing null and <null>, and replacing number or integer to string
        guard var dictResponse = response as? NSDictionary else{
            return JSON.null
        }
        
        dictResponse = (dictResponse.replacingNullsWithStrings() as NSDictionary).convertingNumbersToStrings()! as NSDictionary
        let jsonResponce = JSON(dictResponse)
        return jsonResponce
    }
    
    func getHeaders() -> [String: String] {
        var headerDictionary = [String: String]()
        
        if UserKey.length > 0 {
            headerDictionary[Constants.KEY_Xapi] = UserKey
        }
        
        if ACCESS_TOKEN.length > 0 {
            headerDictionary[Constants.KEY_AccessToken] = ACCESS_TOKEN
        }
        
        print("\nheaderDictionary : \(headerDictionary)")
        return headerDictionary
    }
}

extension String {
    func add(urlString: String) -> URL {
        return URL(string: self + urlString)!
    }
    
    func EncodingText() -> Data {
        return self.data(using: String.Encoding.utf8, allowLossyConversion: false)!
    }
}

extension UIWindow {
    
    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(vc: rootViewController)
        }
        return nil
    }
    
    class func getVisibleViewControllerFrom(vc:UIViewController) -> UIViewController {
        
        switch(vc){
        case is UINavigationController:
            let navigationController = vc as! UINavigationController
            return UIWindow.getVisibleViewControllerFrom( vc: navigationController.visibleViewController!)
            
        case is UITabBarController:
            let tabBarController = vc as! UITabBarController
            return UIWindow.getVisibleViewControllerFrom(vc: tabBarController.selectedViewController!)
            
        default:
            if let presentedViewController = vc.presentedViewController {
                //print(presentedViewController)
                if let presentedViewController2 = presentedViewController.presentedViewController {
                    return UIWindow.getVisibleViewControllerFrom(vc: presentedViewController2)
                }
                else{
                    return vc;
                }
            }
            else{
                return vc;
            }
        }
    }
}
