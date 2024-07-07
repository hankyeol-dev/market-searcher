//
//  RealmUser.swift
//  ddonawa
//
//  Created by 강한결 on 7/7/24.
//

import Foundation
import RealmSwift


class RealmUserSearch: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var keyword: String
    
    convenience init(keyword: String) {
        self.init()
        
        self.keyword = keyword
    }
}

class RealmProduct: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var thumb: String
    @Persisted var price: String
    @Persisted var link: String
    
    convenience init(id: String, name: String, thumb: String, price: String, link: String) {
        self.init()
        
        self.id = id
        self.name = name
        self.thumb = thumb
        self.price = price
        self.link = link
    }
}
