//
//  zQMKFStatus.swift
//  qmkf
//
//  Created by Mac on 2019/12/7.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

func loginStauts() -> Bool {
    return UserDefaults.standard.bool(forKey: "login")
}

func setLoginStauts(_ status : Bool) {
    UserDefaults.standard.set(status, forKey: "login")
}

func userType() -> UserType {
    let userType = UserDefaults.standard.object(forKey: "userType") as? String
    if userType == UserType.TypeUser.rawValue {
        return .TypeUser
    } else {
        return .TypeJinJiRen
    } 
}

func setUserType(_ userType : UserType) { 
    UserDefaults.standard.set(userType.rawValue, forKey: "userType")
}
