//
//  forValidation.swift
//  ddonawa
//
//  Created by 강한결 on 6/21/24.
//

import Foundation

struct NickValidationService {
    private init() {}
    
    enum Errors: Error {
        case isEmpty
        case isLowerThanTwo
        case isContainNumber
        case isContainSpecialLetter
    }
    
    static let service = NickValidationService()
    
    func validateNickByTotal(_ t: String) throws {
        if isEmpty(t) {
            throw Errors.isEmpty
        }
        
        if isLowerThanTwo(t) {
            throw Errors.isLowerThanTwo
        }
        
        if isContainNumber(t) {
            throw Errors.isContainNumber
        }
        
        if isContainSpecialLetter(t) {
            throw Errors.isContainSpecialLetter
        }

    }
    private func isEmpty(_ t: String) -> Bool {
        return t.isEmpty
    }
    
    private func isLowerThanTwo(_ t: String) -> Bool {
        return t.count < 2
    }
    
    private func isContainNumber(_ c: String) -> Bool {
        let array = Array(c)
        return _filter(array, {Int(String($0)) == nil}).count != array.count
    }
    
    private func isContainSpecialLetter(_ c: String) -> Bool {
        let array = Array(c)
        return  _filter(array, { $0 != "@" && $0 != "#" && $0 != "$" && $0 != "%" }).count != array.count
    }
    
}
