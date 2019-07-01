//
//  LoginRouter.swift
//  DemoViperWithAPI
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import Foundation
import UIKit

class LoginRouter: PresenterToRouterLoginProtocol {
    static func createLoginModule() -> LoginViewController {
        let view = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        let presenter : ViewToPresenterLoginProtocol & InteractorToPresenterLoginProtocol = LoginPresentor()
        var interactor: PresenterToInteractorLoginProtocol = LoginInteractor()
        let router: PresenterToRouterLoginProtocol = LoginRouter()
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        view.loginPresentor = presenter
        interactor.presenter = presenter
        
        return view
    }
    
    static var storyBoard : UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    public func pushToHome(using navController: UINavigationController) {
        DispatchQueue.main.async {
            let homeVC = HomeRouter.createHomeModule()
            navController.pushViewController(homeVC, animated: true)
        }
    }
}
