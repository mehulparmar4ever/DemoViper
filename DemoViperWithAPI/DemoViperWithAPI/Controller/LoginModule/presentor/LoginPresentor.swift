//
//  LoginPresentor.swift
//  DemoViperWithAPI
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import Foundation
import UIKit

class LoginPresentor: ViewToPresenterLoginProtocol {
    var view: PresenterToViewLoginProtocol?
    var interactor: PresenterToInteractorLoginProtocol?
    var router: PresenterToRouterLoginProtocol?
    
    func login(using loginModel: LoginModel) {
        interactor?.login(using: loginModel)
    }
    
    func pushToHome(using navigationController: UINavigationController) {
        router?.pushToHome(using: navigationController)
    }
}

extension LoginPresentor : InteractorToPresenterLoginProtocol {
    func onLoginFetchSuccess(userDetail: UserDataModel) {
        view?.onLoginResponseSuccess(userDetail: userDetail)
    }
    
    func onLoginFetchFail(message: String) {
        view?.onLoginResponseFail(message: message)
    }
}
