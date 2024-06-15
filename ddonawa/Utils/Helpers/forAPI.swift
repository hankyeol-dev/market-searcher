//
//  APIHelper.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import Foundation
enum SortType: String {
    case sim = "sim"
    case date = "date"
    case asc = "asc"
    case dsc = "dsc"
}

func _mappingURL(query: String, start: Int, sort: SortType) -> String {
    
    return API.getBaseURL + "query=\(query)&start=\(String(start))&sort=\(sort.rawValue)"
}
