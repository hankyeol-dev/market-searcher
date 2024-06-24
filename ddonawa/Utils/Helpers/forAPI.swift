//
//  APIHelper.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import Alamofire

enum SortType: String {
    case sim = "sim"
    case date = "date"
    case asc = "asc"
    case dsc = "dsc"
}

func _mappingURL(query: String, start: Int, sort: SortType) -> String {
    return API.getBaseURL + "query=\(query)&start=\(String(start))&sort=\(sort.rawValue)"
}

class FetchManager {
    private init() {}
    
    static func _fetch(url: String, headers: HTTPHeaders, successHandler: @escaping (ProductResult) -> (), failHandler: @escaping (AFError) -> ()) {
        AF.request(url, headers: headers).responseDecodable(of: ProductResult.self) { res in
            switch res.result {
            case .success(let product):
                successHandler(product)
            case .failure(let error):
                failHandler(error)
            }
        }
    }
}
