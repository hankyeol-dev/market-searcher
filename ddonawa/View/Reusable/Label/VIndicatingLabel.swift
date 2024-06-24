//
//  VIndicatingLabel.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import UIKit

enum IndicatingType {
    case normal
    case success
    case fail
}

class VIndicatingLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
        
        font = ._sm
        text = Texts.Indicator.NICKNAME_ERROR_EMPTY.rawValue
        textColor = ._gray_md
    }
    
    func startEditing() {
        text = Texts.Indicator.NICKNAME_EDITING_START.rawValue
    }
    
    func isLowerThanTwoOrOverTen() {
        textColor = ._tint_error
        text = Texts.Indicator.NICKNAME_ERROR_COUNT.rawValue
    }
 
    func isEmpty() {
        textColor = ._gray_md
        text = Texts.Indicator.NICKNAME_ERROR_EMPTY.rawValue
    }
    
    func isContainsNumber() {
        textColor = ._tint_error
        text = Texts.Indicator.NICKNAME_ERROR_NUMBER.rawValue
    }
    
    func isContainsSpecialLetter() {
        textColor = ._tint_error
        text = Texts.Indicator.NICKNAME_ERROR_SPECIAL_LETTER.rawValue
    }
    
    func isSuccess() {
        textColor = ._main
        text = Texts.Indicator.NICKNAME_SUCCESS.rawValue
    }
}
