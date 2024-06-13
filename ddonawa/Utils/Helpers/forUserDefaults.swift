//
//  forUserDefaults.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import Foundation

enum ControlUser {
    private static let key = "user"
    
    static var isSavedUser: Bool {
        return UserDefaults.standard.object(forKey: self.key) != nil
    }
    
    static var getOrSaveUser: User {
        get {
            return try! JSONDecoder().decode(User.self, from: UserDefaults.standard.object(forKey: self.key) as! Data)
        }
        
        set {
            if let data = try? JSONEncoder().encode(newValue as User) {
                UserDefaults.standard.setValue(data, forKey: self.key)
            }
        }
    }
    
    static var deleteUser: Void {
        UserDefaults.standard.removeObject(forKey: self.key)
    }
}
