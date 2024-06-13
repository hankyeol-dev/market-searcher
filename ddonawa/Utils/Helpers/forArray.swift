//
//  ArrayHelper.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import Foundation

func _map<T, R>(_ array: [T], _ cb: (T) -> R) -> [R] {
    var resultArray: [R] = []
    
    for el in array {
        resultArray.append(cb(el))
    }
    
    return resultArray
}

func _filter<T>(_ array: [T], _ cb: (T) -> Bool) -> [T] {
    var resultArray: [T] = []
    
    for el in array {
        if cb(el) {
            resultArray.append(el)
        }
    }
    
    return resultArray
}

func _forEach<T>(_ array: [T], _ cb: (T) -> Void) {
    for el in array {
        cb(el)
    }
}
