//
//  VLabel.swift
//  ddonawa
//
//  Created by 강한결 on 6/15/24.
//

import UIKit

enum VlabelType {
    case impact
    case normal
    case sub
}

class VLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ t: String, tColor: UIColor = ._black, tType: VlabelType) {
        self.init(frame: .zero)
        
        text = t
        textColor = tColor
        
        switch tType {
        case .impact:
            font = ._mdBold
        case .normal:
            font = ._md
        case .sub:
            font = ._sm
        }
    }
    
    func changeLabelText(_ t: String) {
        text = t
    }
}
