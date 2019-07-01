//
//  HomeInteractor.swift
//  DemoViperWithAPI
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import Foundation

class HomeInteractor: PresenterToInteractorHomeProtocol {
    var presenter: InteractorToPresenterHomeProtocol?
    
    func getBarberList(using user: HomeModel) {
        APIService().listuser(username: user.username, page: user.page, success: { (response) in
            if let strPage  = (ModelManager.sharedInstance.getResponseDataModel(response.dictionaryObject! as NSDictionary)).page {
                print("next page:" + strPage)
                
                let freshData = ModelManager
                    .sharedInstance
                    .getUserModelArray(((ModelManager.sharedInstance.getResponseDataModel(response.dictionaryObject! as NSDictionary)).data as! NSDictionary).value(forKey: "users") as! NSArray)
                if freshData.count > 0 {
                    self.presenter?.onHomeFetchSuccess(arrUserDetail: freshData)
                }
                else {
                    self.presenter?.onHomeFetchFail(message: "No user found")
                }
            }
            else {
                self.presenter?.onHomeFetchFail(message: "No user found")
            }
        }, failure: { (error) in
            print(error as Any)
            
            self.presenter?.onHomeFetchFail(message: "No user found")
        })
    }
    
    func logout(using userId: String) {
        CustomAlert().ShowAlert(isCancelButton: true, strMessage: AppAlertMsg.KLogout, completion: { (isYESClicked) in
            if(isYESClicked){
                APIService().logout(false, strUserId: userId, success: { (response) in
                    self.presenter?.isLogout(isCompleted: true, message: "Logout done")
                }) { (error) in
                    print(error as Any)
                    self.presenter?.isLogout(isCompleted: false, message: "Something went wrong!!")
                }
            }
        })
    }
}
