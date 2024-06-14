//
//  MainButton.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import UIKit

class VButton: UIButton {
    
    convenience init(_ btnText: String) {
        self.init(frame: .zero)
        setTitle(btnText, for: .normal)
        titleLabel?.font = ._lgBold
        setTitleColor(._white, for: .normal)
        backgroundColor = ._main
        layer.cornerRadius = 24
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeColorByDisabled() {
        isEnabled = false
        backgroundColor = ._gray_md
        setTitleColor(._gray_sm, for: .disabled)
    }
    
    func changeColorByEnabled() {
        isEnabled = true
        backgroundColor = ._main
        setTitleColor(._white, for: .normal)
    }

}

