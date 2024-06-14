//
//  VLogo.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import UIKit

class VLogo: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ logoText: String) {
        self.init(frame: .zero)
        text = logoText
        font = .boldSystemFont(ofSize: 32)
        textColor = ._main
        textAlignment = .center
    }
}
