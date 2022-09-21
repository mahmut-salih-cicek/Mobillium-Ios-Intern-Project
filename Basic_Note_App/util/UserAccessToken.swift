//
//  UserAccessToken.swift
//  Basic_Note_App
//
//  Created by xmod on 3.08.2022.
//

import Foundation



class UserAccessToken {

    // User Access Token get func
    static func value<T>(defaultValue: T, forKey key: String) -> T{
        let preferences = UserDefaults.standard
        return preferences.object(forKey: key) == nil ? defaultValue : preferences.object(forKey: key) as! T
    }

    // User Accrss Token set func
    static func value(value: Any, forKey key: String){
        UserDefaults.standard.set(value, forKey: key)
    }

}
