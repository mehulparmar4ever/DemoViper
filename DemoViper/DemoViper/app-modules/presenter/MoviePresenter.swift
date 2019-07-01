//
//  MoviePresenter.swift
//  DemoViper
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import Foundation

class MoviePresenter: ViewToPresenterMovieProtocol {
    
    var view: PresenterToViewMovieProtocol?
    var interactor: PresenterToInteractorMovieProtocol?
    var router: PresenterToRouterMovieProtocol?
    
    func startFetchingMovie() {
        interactor?.fetchMovies()
    }
}

extension MoviePresenter : InteractorToPresenterMovieProtocol {
    func onMovieFetchSuccess(movieList: [MovieModel]) {
        view?.onMovieResponseSuccess(movieList: movieList)
    }
    
    func onMovieFetchFailed() {
        view?.onMovieResponseFailed(error: "Please try again later, Something went wrong!!")
    }
}
