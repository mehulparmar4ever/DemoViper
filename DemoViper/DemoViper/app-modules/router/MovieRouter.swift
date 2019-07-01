//
//  MovieRouter.swift
//  DemoViper
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import Foundation
import UIKit

class MovieRouter: PresenterToRouterMovieProtocol {
    static func createMovieModule() -> MovieListViewController {
        
        let view = MovieRouter.mainStoryBoard.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        
        let presenter: ViewToPresenterMovieProtocol & InteractorToPresenterMovieProtocol = MoviePresenter()
        let interactor: PresenterToInteractorMovieProtocol = MovieInteractor()
        let router: PresenterToRouterMovieProtocol = MovieRouter()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor

        view.moviePresenter = presenter
        
        interactor.presenter = presenter
    
        return view
    }
    
    static var mainStoryBoard : UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
