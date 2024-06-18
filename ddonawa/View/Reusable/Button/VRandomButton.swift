//
//  VRandomButton.swift
//  ddonawa
//
//  Created by 강한결 on 6/17/24.
//

import UIKit

extension UIButton.Configuration {
    static func _roundFilledButton(_ t: String, color: UIColor = ._main, tColor: UIColor = ._white) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        var attributedT = AttributedString.init(t)
        attributedT.font = ._sm
        
        configuration.attributedTitle = attributedT
        configuration.baseBackgroundColor = color
        configuration.baseForegroundColor = tColor
        configuration.titleAlignment = .center
        
        return configuration
    }
}
