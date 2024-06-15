//
//  VFilterButton.swift
//  ddonawa
//
//  Created by 강한결 on 6/15/24.
//

import UIKit

class VFilterButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ t: String) {
        self.init(frame: .zero)
        
        setTitle(t, for: .normal)
        setTitleColor(._gray_lg, for: .normal)
        titleLabel?.font = ._xs
        backgroundColor = .systemBackground
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor._gray_lg.cgColor
    }
    
    func isSelected() {
        setTitleColor(._white, for: .normal)
        backgroundColor = ._gray_lg
    }
    
    func disSelected() {
        setTitleColor(._black, for: .normal)
        backgroundColor = .systemBackground
    }
}
