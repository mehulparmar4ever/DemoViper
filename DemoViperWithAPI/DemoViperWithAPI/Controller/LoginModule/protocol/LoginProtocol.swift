//
//  LoginProtocol.swift
//  DemoViperWithAPI
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterLoginProtocol : class {
    var view: PresenterToViewLoginProtocol? {get set}
    var interactor: PresenterToInteractorLoginProtocol? {get set}
    var router: PresenterToRouterLoginProtocol? {get set}
    
    func login(using loginModel: LoginModel)
    func pushToHome(using navigationController:UINavigationController)
}

protocol InteractorToPresenterLoginProtocol {
    func onLoginFetchSuccess(userDetail: UserDataModel)
    func onLoginFetchFail(message: String)
}

protocol PresenterToViewLoginProtocol {
    func onLoginResponseSuccess(userDetail: UserDataModel)
    func onLoginResponseFail(message: String)
}

protocol PresenterToInteractorLoginProtocol {
    var presenter: InteractorToPresenterLoginProtocol? {get set}
    
    func login(using loginModel: LoginModel)
}

protocol PresenterToRouterLoginProtocol {
    static func createLoginModule() -> LoginViewController
    func pushToHome(using navController: UINavigationController)
}

