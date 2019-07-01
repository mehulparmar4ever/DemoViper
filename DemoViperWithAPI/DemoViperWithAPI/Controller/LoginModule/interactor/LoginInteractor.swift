//
//  LoginInteractor.swift
//  DemoViperWithAPI
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import Foundation

class LoginInteractor: PresenterToInteractorLoginProtocol {
    var presenter: InteractorToPresenterLoginProtocol?
    
    func login(using loginModel: LoginModel) {
        APIService().login(email: loginModel.email,
                           password: loginModel.password,
                           success: { (response) in
                            let userDetail = ModelManager.sharedInstance.getUserDataModel((ModelManager.sharedInstance.getResponseDataModel(response.dictionaryObject! as NSDictionary)).data as! NSDictionary)
                            
                            UserKey = (ModelManager.sharedInstance.getResponseDataModel(response.dictionaryObject! as NSDictionary)).key
                            self.presenter?.onLoginFetchSuccess(userDetail: userDetail)
        }) { (error) in
            if let jsonError = error {
                let responseModel : ResponseDataModel  = (ModelManager.sharedInstance.getResponseDataModel(jsonError.dictionaryObject! as NSDictionary))
                self.presenter?.onLoginFetchFail(message: responseModel.message)
            }
        }
    }
}
