//
//  APIService.swift
//  TOYIN
//
//  Created by Mehul Parmar on 06/04/19.
//  Copyright © 2018 TOYIN. All rights reserved.
//  LinkedIn: https://www.linkedin.com/in/mehul-p-20268539/

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

open class APIService : NSObject {
    enum API {
        enum Login : String {
            case login = "api/user/login"
            case logout = "api/user/logout"
        }

        enum User : String {
            case listuser = "api/user/listuser"
            case listuser_without_login = "api/user/listuser_without_login"
        }
    }
    
    func login(email: String, password: String, success:@escaping (_ responseObject:JSON) -> Void , failure:@escaping (_ errorResponse:JSON?) -> Void) {
        
        // create request parameter
        let requestParameters = ["username"     :   email,
                                 "password"     :   password
        ]
        
        // create post request
        NetworkManager().POST(API.Login.login.rawValue,
                              paramaters: requestParameters as [String : AnyObject]?,
                              showLoader: true,
                              success: { responseObject in
                                success(responseObject)
        }) { error in
            failure(error)
        }
    }
    
    
    func logout(_ isDelete:Bool?, strUserId: String, success:@escaping (_ responseObject:JSON) -> Void , failure:@escaping (_ errorResponse:JSON?) -> Void) {
        
        // create request parameter
        var requestParameters = ["id"        :   strUserId]
        
        if let isDeleteTemp = isDelete {
            if isDeleteTemp {
                requestParameters = [
                    "id"        :   strUserId,
                    "is_delete"     :   "1"
                ]
            }
        }
        
        // create post request
        NetworkManager().POST(API.Login.logout.rawValue,
                              paramaters: requestParameters as [String : AnyObject]?,
                              showLoader: true,
                              success: { responseObject in
                                success(responseObject)
        }) { error in
            failure(error)
        }
    }

    func listuser(
        username:String? = "",
        page: String,
        success:@escaping (_ responseObject:JSON) -> Void , failure:@escaping (_ errorResponse:JSON?) -> Void) {
        
        // create request parameter
        let requestParameters = [
            "username"  :   username    ??  "",
            "page"      :    page,
            "price"     :   "",
            "expertice_id": "",
            "service_id":   "",
            "get_my_employees"     :    "0"
        ]
        
        guard let username = UserDetail.username, username.length > 0 else {
            NetworkManager().POST(API.User.listuser_without_login.rawValue,
                                  paramaters: requestParameters as [String : AnyObject]?,
                                  showLoader: false,
                                  success: { responseObject in
                                    success(responseObject)
            }) { error in
                failure(error)
            }

            return
        }
        
        // create post request
        NetworkManager().POST(API.User.listuser.rawValue,
                              paramaters: requestParameters as [String : AnyObject]?,
                              showLoader: false,
                              success: { responseObject in
                                success(responseObject)
        }) { error in
            failure(error)
        }
    }
}
