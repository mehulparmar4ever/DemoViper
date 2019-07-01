//
//  HomeProtocol.swift
//  DemoViperWithAPI
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import Foundation

protocol ViewToPresenterHomeProtocol : class {
    var view: PresenterToViewHomeProtocol? {get set}
    var interactor: PresenterToInteractorHomeProtocol? {get set}
    var router: PresenterToRouterHomeProtocol? {get set}
    
    func fetchingBarberList(using user: HomeModel)
    func logout(using userId: String)
}

protocol InteractorToPresenterHomeProtocol {
    func onHomeFetchSuccess(arrUserDetail: [UserModel])
    func onHomeFetchFail(message: String)
    
    func isLogout(isCompleted: Bool, message: String)
}

protocol PresenterToViewHomeProtocol {
    func onHomeResponseSuccess(arrUserDetail: [UserModel])
    func onHomeResponseFail(message: String)
    
    func isLogout(isCompleted: Bool, message: String)
}

protocol PresenterToInteractorHomeProtocol {
    var presenter: InteractorToPresenterHomeProtocol? {get set}
    
    func getBarberList(using user: HomeModel)
    func logout(using userId: String)
}

protocol PresenterToRouterHomeProtocol {
    static func createHomeModule() -> HomeViewController
}

