//
//  EnumManager.swift
//  TOYIN
//
//  Created by Mehul Parmar on 06/04/19.
//  Copyright © 2018 TOYIN. All rights reserved.
//  LinkedIn: https://www.linkedin.com/in/mehul-p-20268539/

import Foundation


enum UserType:String {
    case Fresh      = "0"
    case Login      = "1"
}

var UserKey:String {
    get{
        return UserDefaults.standard.string(forKey: "Constants.hbUserStatus") ?? ""
    }
    set(status){
        UserDefaults.standard.set(status, forKey: "Constants.hbUserStatus")
        UserDefaults.standard.synchronize()
    }
}


var ACCESS_TOKEN:String {
    get{
        return UserDefaults.standard.string(forKey: "ACCESS_TOKEN") ?? ""
    }
    
    set(data){
        UserDefaults.standard.set(data, forKey: "ACCESS_TOKEN")
        UserDefaults.standard.synchronize()
    }
}
