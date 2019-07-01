//
//  LoginViewController.swift
//  DemoViperWithAPI
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var loginPresentor : ViewToPresenterLoginProtocol? = nil
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ACCESS_TOKEN = UIDevice.current.identifierForVendor?.uuidString ?? "12345678901234"
    }
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        if validateLoginData() {
            self.view.endEditing(true)
            
            let loginModel = LoginModel.init(email: self.txtEmail.text!, password: self.txtPassword.text!)
            loginPresentor?.login(using: loginModel)
        }
    }
    
    func validateLoginData() -> Bool {
        if txtEmail.text!.isEmpty {
            CustomAlert().ShowAlert(AppAlertMsg.KEmailEmpty)
            return false
        }
        else if !(txtEmail.text!.trimmed()).isValidEmail() {
            CustomAlert().ShowAlert(AppAlertMsg.KValidEmail)
            return false
        }
        else if txtPassword.text!.isEmpty {
            CustomAlert().ShowAlert(AppAlertMsg.kPassword)
            return false
        }
        else if txtPassword.text!.count < 6 {
            CustomAlert().ShowAlert(AppAlertMsg.kValidPassword)
            return false
        }
        else {
            return true
        }
    }
}

extension LoginViewController: PresenterToViewLoginProtocol {
    func onLoginResponseSuccess(userDetail: UserDataModel) {
        UserDetail = userDetail
        
        UserStatus = UserType.Login.rawValue
        
        self.txtEmail.text = ""
        self.txtPassword.text = ""
        
        self.loginPresentor?.pushToHome(using: self.navigationController!)
    }
    
    func onLoginResponseFail(message: String) {
        CustomAlert().ShowAlert(message)
    }
}
