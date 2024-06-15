//
//  User.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import Foundation


struct User: Codable {
    private var nickname: String
    private var image: ProfileImage
    private var liked: [ProductUserLiked]
    private var recentSearch: [String]
    private static var key = "user"
    
    init(nickname: String, image: ProfileImage, liked: [ProductUserLiked] = [], recentSearch: [String] = []) {
        self.nickname = nickname
        self.image = image
        self.liked = liked
        self.recentSearch = recentSearch
    }
    
    var getOrChangeNick: String {
        get {
            return self.nickname
        }
        
        set {
            self.nickname = newValue
        }
    }
    
    var getOrChangeImage: ProfileImage {
        get {
            return self.image
        }
        
        set {
            self.image = newValue
        }
    }
    
    var getLiked: [ProductUserLiked] {
        return self.liked
    }
    
    var getRecentSearch: [String] {
        return self.recentSearch
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
    
    mutating func isInLiked(_ productId: String) -> Bool {
        return _filter(self.liked, { $0.productId == productId }).count != 0
    }
    
    mutating func addLiked(_ product: ProductUserLiked) {
        self.liked.append(product)
    }
    
    mutating func deleteLiked(_ productId: String) {
        self.liked = _filter(self.liked, { $0.productId != productId })
    }
    
    mutating func addRecentSearch(_ keyword: String) {
        self.recentSearch.append(keyword)
    }
    
    mutating func deleteRecentSearch(_ keywordId: Int) {
        self.recentSearch.remove(at: self.recentSearch.count - 1 - keywordId)
    }
    
    mutating func deleteAllRecentSearch() {
        self.recentSearch = []
    }
}
