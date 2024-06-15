//
//  UI.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import UIKit

extension UIColor {
    static let _main = UIColor(red: 239/255, green: 137/255, blue: 71/255, alpha: 1)
    static let _black = UIColor.black
    static let _tint_error = UIColor(red: 225/255, green: 29/255, blue: 72/255, alpha: 1)
    static let _gray_lg = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1)
    static let _gray_md = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
    static let _gray_sm = UIColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1)
    static let _white = UIColor.white
}

extension UIFont {
    static let _xs = UIFont.systemFont(ofSize: 11)
    static let _sm = UIFont.systemFont(ofSize: 13)
    static let _md = UIFont.systemFont(ofSize: 14)
    static let _lg = UIFont.systemFont(ofSize: 15)
    static let _xl = UIFont.systemFont(ofSize: 16)
    static let _smBold = UIFont.boldSystemFont(ofSize: 13)
    static let _mdBold = UIFont.boldSystemFont(ofSize: 14)
    static let _lgBold = UIFont.boldSystemFont(ofSize: 15)
    static let _xlBold = UIFont.boldSystemFont(ofSize: 16)
}

extension UIImage {
    static let _launch = UIImage(named: "launch")
    static let _empty = UIImage(named: "empty")
    
    enum profile: String, CaseIterable {
        case _profile_0 = "profile_0"
        case _profile_1 = "profile_1"
        case _profile_2 = "profile_2"
        case _profile_3 = "profile_3"
        case _profile_4 = "profile_4"
        case _profile_5 = "profile_5"
        case _profile_6 = "profile_6"
        case _profile_7 = "profile_7"
        case _profile_8 = "profile_8"
        case _profile_9 = "profile_9"
        case _profile_10 = "profile_10"
        case _profile_11 = "profile_11"
    }
}
