//
//  UserService.swift
//  ddonawa
//
//  Created by 강한결 on 6/21/24.
//

import UIKit

class UserService {
    private enum keys: String {
        case nick
        case img
    }
    static let service = UserService()
    private let defaults = UserDefaults.standard
    
    private init() {}
        
    var getOrSetUserNick: String {
        get {
            getDefaultsValue(keys.nick.rawValue)
        }
        set {
            defaults.setValue(newValue, forKey: keys.nick.rawValue)
        }
    }
    
    var getOrSetUserProfileImage: UIImage {
        get {
            UIImage(named: getDefaultsValue(keys.img.rawValue))!
        }
        set {
            defaults.setValue(newValue, forKey: keys.img.rawValue)
        }
    }
    
    private func getDefaultsValue(_ key: keys.RawValue) -> String {
        return defaults.string(forKey: key) ?? ""
    }
}
