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
    
    mutating func addLiked(_ product: Product) {
        self.liked.append(product)
    }
    
    mutating func deleteLiked(_ productId: String) {
        self.liked = _filter(self.liked, { $0.productId != productId })
    }
    
    init(nickname: String, image: String, liked: [Product]) {
        self.nickname = nickname
        self.image = image
        self.liked = liked
    }
}
