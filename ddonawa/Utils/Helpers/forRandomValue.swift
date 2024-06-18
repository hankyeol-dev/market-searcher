//
//  forRandomValue.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import Foundation

struct RandomGenerator {
    static let nicknames = [
        ["건방진", "착한", "화난", "심각한", "관대한", "가혹한", "달콤한", "형편없는", "진지한", "화려한", "단단한", "위험한", "이기적인", "흔한", "암담한", "포근한", "싫증나는", "놀라운", "어지러운", "이타적인", "감미로운", "못생긴", "예쁜"],
        ["실사용자", "배도라지", "차조기떡", "빼갈", "어향가지", "멘보샤", "역지사지", "전지현", "아이맥스", "타르타르", "너구리", "짜파게티", "사대주의자", "반지하방", "사지동물", "대청마루", "대감마님"]
    ]
    
    static func _getRandomElement<T>(_ array: [T]) -> T {
        return array[Int.random(in: 0..<array.count)]
    }
    
    static func _getRandomNick() -> String {
        let ran1 = Int.random(in: 0..<nicknames[0].count)
        let ran2 = Int.random(in: 0..<nicknames[1].count)
        
        return nicknames[0][ran1] + nicknames[1][ran2]
    }
}

