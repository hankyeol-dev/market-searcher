//
//  User.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import Foundation


struct User: Codable {
    private var nickname: String
    private var image: String
    private var liked: [Product]
    private static var key = "user"
    
    init(nickname: String, image: String, liked: [Product] = []) {
        self.nickname = nickname
        self.image = image
        self.liked = liked
    }
    
    var getOrChangeNick: String {
        get {
            return self.nickname
        }
        
        set {
            self.nickname = newValue
        }
    }
    
    var getOrChangeImage: String {
        get {
            return self.image
        }
        
        set {
            self.image = newValue
        }
    }
    
    var getLiked: [Product] {
        get {
            return self.liked
        }
    }
    
    static var isSavedUser: Bool {
        return UserDefaults.standard.object(forKey: User.key) != nil
    }
    
    static var getOrSaveUser: User {
        get {
            return try! JSONDecoder().decode(User.self, from: UserDefaults.standard.object(forKey: User.key) as! Data)
        }
        
        set {
            if let data = try? JSONEncoder().encode(newValue as User) {
                UserDefaults.standard.setValue(data, forKey: User.key)
            }
        }
    }
    
    static var deleteUser: Void {
        UserDefaults.standard.removeObject(forKey: User.key)
    }
    
    mutating func addLiked(_ product: Product) {
        self.liked.append(product)
    }
    
    mutating func deleteLiked(_ productId: String) {
        self.liked = _filter(self.liked, { $0.productId != productId })
    }

}
