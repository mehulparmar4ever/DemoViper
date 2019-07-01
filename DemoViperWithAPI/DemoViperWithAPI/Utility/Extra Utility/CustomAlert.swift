//
//  SmoothAlert.swift
//  TOYIN
//
//  Created by Mehul Parmar on 06/04/19.
//  Copyright © 2018 TOYIN. All rights reserved.
//  LinkedIn: https://www.linkedin.com/in/mehul-p-20268539/

import Foundation
import SDCAlertView

class CustomAlert {
    func ShowAlert(_ strMessage: String) {
        let alert = AlertController(title: Constants.kAppName, message: strMessage, preferredStyle: .alert)
        alert.addAction(AlertAction(title: "OK", style: .normal))
        alert.actionLayout = .automatic
        alert.present()
    }
    
    func ShowAlert(isCancelButton: Bool,  strMessage: String, completion:@escaping (Bool) -> Void) {
        let alert = AlertController(title: Constants.kAppName, message: strMessage, preferredStyle: .alert)
        
        var strTitle = AppAlertMsg.kOk
        if isCancelButton {
            strTitle = AppAlertMsg.kYes
            
            let cancelAction = AlertAction.init(title: AppAlertMsg.kNo, style: .preferred, handler: { (alertaction) in
                completion(false)
            })
            alert.addAction(cancelAction)
        }
        
        let okAction = AlertAction.init(title: strTitle, style: .normal, handler: { (alertaction) in
            completion(true)
        })
        alert.addAction(okAction)
        
        //        alert.add(AlertAction(title: "Delete", style: .destructive))
        
        alert.actionLayout = .automatic
        alert.present()
    }
    
    func ShowAlert(isCancelButton: Bool,  strTitle: String ,strMessage: String, strTrue: String, strFalse: String, completion:@escaping (Bool) -> Void) {
        
        let alert = AlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
        
        if isCancelButton {
            let cancelAction = AlertAction.init(title: strFalse, style: .preferred, handler: { (alertaction) in
                completion(false)
            })
            alert.addAction(cancelAction)
        }
        
        let okAction = AlertAction.init(title: strTrue, style: .normal, handler: { (alertaction) in
            completion(true)
        })
        alert.addAction(okAction)
        
        alert.actionLayout = .automatic
        alert.present()
    }
    
    func ShowAlert1(isCancelButton: Bool,  strMessage: String, completion:@escaping (Bool) -> Void) {
        let alert = AlertController(title: Constants.kAppName, message: strMessage, preferredStyle: .alert)
        let okAction = AlertAction.init(title: "YES", style: .normal, handler: { (alertaction) in
            completion(true)
        })
        alert.addAction(okAction)
        
        if isCancelButton {
            let cancelAction = AlertAction.init(title: "NO", style: .preferred, handler: { (alertaction) in
                completion(false)
            })
            alert.addAction(cancelAction)
        }
//        alert.add(AlertAction(title: "Delete", style: .destructive))
        
        alert.actionLayout = .automatic
        alert.present()
    }
    
    func Alert(title: String?, message: String?, actionTitles:[String?], actions:[((AlertAction) -> Void)?]) {
        
        let alert = AlertController(title: title, message: message, preferredStyle: .alert)

        for (index, title) in actionTitles.enumerated() {
            let action = AlertAction.init(title: title, style: .normal, handler: actions[index])
            alert.addAction(action)
        }
        
        alert.actionLayout = .automatic
        alert.present()
    }
    
    func Action(title: String?, message: String?, actionTitles:[String?], actions:[((AlertAction) -> Void)?]) {
        
        let alert = AlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.outsideTapHandler = {
            alert.dismiss()
        }
        
        for (index, title) in actionTitles.enumerated() {
            let action = AlertAction.init(title: title, style: .normal, handler: actions[index])
            alert.addAction(action)
        }
        
        alert.actionLayout = .automatic
        alert.present()
    }
}
