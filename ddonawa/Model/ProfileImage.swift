//
//  ProfileImage.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import Foundation

struct ProfileImage: Codable {
    static private var key = "selectedId"
    let id: Int
    let sourceName: String
    
    static var getOrSetId: Int {
        get {
            return UserDefaults.standard.integer(forKey: ProfileImage.key)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: ProfileImage.key)
        }
    }
}
