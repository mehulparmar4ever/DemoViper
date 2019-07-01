//
//  StaticConstantManager.swift
//  TOYIN
//
//  Created by Mehul Parmar on 06/04/19.
//  Copyright © 2018 TOYIN. All rights reserved.
//  LinkedIn: https://www.linkedin.com/in/mehul-p-20268539/

import Foundation
import UIKit

struct DateFormate {
    static let dateFormat_Long                      = "yyyy-MM-dd HH:mm:ss"
    static let dateFormat_AM_PM                     = "yyyy-MM-dd h:mm a"
    static let dateFormat_Date_only                 = "yyyy-MM-dd"
    static let dateFormat_Time_only                 = "h:mm a"
}


struct Constants {
    static let kAppName        = "Demo Viper"
    static let KEY_Xapi                             = "X-API-KEY"
    static let KEY_AccessToken                      = "ACCESS-TOKEN"

    static let appDelegate                  =   UIApplication.shared.delegate as! AppDelegate
    static let mainStoryboard: UIStoryboard =   UIStoryboard(name: "Main", bundle: nil)
    
    //User Default constant
    static let dateFormat_Booking                   = "HH.mm - EEEE, d MMM yyyy"
    static let dateFormat                           = "yyyy-MM-dd HH:mm:ss"
    static let dateFormat_AM_PM                     = "yyyy-MM-dd h:mm a"
    static let dateFormat_Date_only                 = "yyyy-MM-dd"
    static let dateFormat_Time_only                 = "h:mm a"
}

//MARK:
//MARK: App alert title & validation messages
//MARK:

struct AppAlertMsg {
    //Validation alert that used in this app
    
    //Alert title
    static let kPleaseWait = "Please wait"
    static let kOk = "OK"
    static let kYes = "Yes"
    static let kNo = "No"
    static let kCancel = "Cancel"
    static let kErrorMsg = "Something went wrong, please try again later"
    
    //Default alert
    static let KLoginToContinue = "To use this features, You have to login\n\n Would you like to login?"
    static let KLogout       = "Are you sure you want to logout?"
    static let KDelete       = "Are you sure you want to delete your account?"

    static let KEmailEmpty = "Please enter email address"
    static let KValidEmail = "Please enter valid email address"
    static let kPassword = "Please enter password"
    static let kValidPassword = "Password length should be minimum 6 characters long"
    static let kUnAuthotized = "Your session has been expired, Please login again"
    static let kNoInternet = "Please check your internet connection."
}
