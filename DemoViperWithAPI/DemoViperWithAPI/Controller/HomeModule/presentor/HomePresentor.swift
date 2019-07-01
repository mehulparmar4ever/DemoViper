//
//  HomePresentor.swift
//  DemoViperWithAPI
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import Foundation

class HomePresentor: ViewToPresenterHomeProtocol {
    var view: PresenterToViewHomeProtocol?
    
    var interactor: PresenterToInteractorHomeProtocol?
    
    var router: PresenterToRouterHomeProtocol?
    
    func fetchingBarberList(using user: HomeModel) {
        interactor?.getBarberList(using: user)
    }
    
    func logout(using userId:String) {
        interactor?.logout(using: userId)
    }
}

extension HomePresentor : InteractorToPresenterHomeProtocol {
    func onHomeFetchSuccess(arrUserDetail: [UserModel]) {
        self.view?.onHomeResponseSuccess(arrUserDetail: arrUserDetail)
    }
    
    func onHomeFetchFail(message: String) {
        self.view?.onHomeResponseFail(message: message)
    }
    
    func isLogout(isCompleted: Bool, message: String) {
        self.view?.isLogout(isCompleted: isCompleted, message: message)
    }
}
