//
//  Product.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import Foundation

struct ProductUserLiked: Codable {
    let productId: String
    let image: String
    let title: String
    let lprice: String
    let link: String
}

struct Product: Decodable {
    let productId: String
    let title: String
    let mallName: String
    let productType: String
    let image: String
    let link: String
    let lprice: String
}

struct ProductResult: Decodable {
    let items: [Product]
    let start: Int
    let total: Int
}
