//
//  APIHelper.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import Foundation

func _mappingURL(_ queryString: [(String, String)]) -> String {
    let endPoint = _map(queryString, { $0.0 + "=" + $0.1 + "&" }).joined()
    return API.getBaseURL + endPoint
}
