//
//  ValidateService.swift
//  ddonawa
//
//  Created by 강한결 on 7/1/24.
//

import Foundation

final class ValidateService {
    private init() {}
    
    enum Errors: Error {
        case isEmpty
        case isLowerThanTwo
        case isOverTen
        case isContainNumber
        case isContainSpecialLetter
    }
    
    static func validateNickname(_ t: String) throws {
        if isEmpty(t) {
            throw Errors.isEmpty
        }
        
        if isLowerThanTwo(t) {
            throw Errors.isLowerThanTwo
        }
        
        if isOverTen(t) {
            throw Errors.isOverTen
        }
        
        if isContainNumber(t) {
            throw Errors.isContainNumber
        }
        
        if isContainSpecialLetter(t) {
            throw Errors.isContainSpecialLetter
        }

    }
    
    private static func isEmpty(_ t: String) -> Bool {
        return t.isEmpty
    }
    
    private static func isLowerThanTwo(_ t: String) -> Bool {
        return t.count < 2
    }
    
    private static func isOverTen(_ t: String) -> Bool {
        return t.count > 10
    }
    
    private static func isContainNumber(_ t: String) -> Bool {
        let array = Array(t)
        return _filter(array, {Int(String($0)) == nil}).count != array.count
    }
    
    private static func isContainSpecialLetter(_ t: String) -> Bool {
        let array = Array(t)
        return  _filter(array, { $0 != "@" && $0 != "#" && $0 != "$" && $0 != "%" }).count != array.count
    }
    
}
