//
//  forRandomValue.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import Foundation

func getRandomElement<T>(_ array: [T]) -> T {
    return array[Int.random(in: 0..<array.count)]
}
