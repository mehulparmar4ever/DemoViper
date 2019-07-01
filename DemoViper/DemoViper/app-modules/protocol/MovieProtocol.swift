//
//  MovieProtocol.swift
//  DemoViper
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import UIKit

//MoviePresenter
protocol ViewToPresenterMovieProtocol: class {
    
    var view: PresenterToViewMovieProtocol? {get set}
    var interactor: PresenterToInteractorMovieProtocol? {get set}
    var router: PresenterToRouterMovieProtocol? {get set}
    
    func startFetchingMovie()
}

protocol PresenterToViewMovieProtocol: class {
    
    func onMovieResponseSuccess(movieList: [MovieModel])
    func onMovieResponseFailed(error: String)
}

protocol PresenterToRouterMovieProtocol: class {
    
    static func createMovieModule() -> MovieListViewController
}

//MovieInteractor
protocol PresenterToInteractorMovieProtocol: class {
    
    var presenter: InteractorToPresenterMovieProtocol? {get set}
    func fetchMovies()
}

protocol InteractorToPresenterMovieProtocol: class {
    
    func onMovieFetchSuccess(movieList: [MovieModel])
    func onMovieFetchFailed()
}
