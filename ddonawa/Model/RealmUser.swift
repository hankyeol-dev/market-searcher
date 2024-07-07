//
//  RealmUser.swift
//  ddonawa
//
//  Created by 강한결 on 7/7/24.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var nickname: String
    @Persisted var profileImage: String
    @Persisted var createdAt: String = _genFormattedDate()
    @Persisted var searchLists: List<RealmUserSearch?>
    @Persisted var likedProducts: List<RealmProduct?>
    
    convenience init(nickname: String, profileImage: String) {
        self.init()
        
        self.nickname = nickname
        self.profileImage = profileImage
    }
}

class RealmUserSearch: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var keyword: String
    
    convenience init(keyword: String) {
        self.init()
        
        self.keyword = keyword
    }
}

class RealmProduct: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var thumb: String
    @Persisted var price: String
    @Persisted var link: String
    
    convenience init(name: String, thumb: String, price: String, link: String) {
        self.init()
        
        self.name = name
        self.thumb = thumb
        self.price = price
        self.link = link
    }
}
