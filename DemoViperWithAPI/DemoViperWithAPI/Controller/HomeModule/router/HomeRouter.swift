//
//  HomeRouter.swift
//  DemoViperWithAPI
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter : PresenterToRouterHomeProtocol {
    static func createHomeModule() -> HomeViewController {
        let view = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let presenter : ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresentor()
        var interactor: PresenterToInteractorHomeProtocol = HomeInteractor()
        let router: PresenterToRouterHomeProtocol = HomeRouter()
        
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
    static var storyBoard : UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
