//
//  VProfileImage.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import UIKit
import SnapKit

enum ViewState {
    case modify
    case noneModify
}

class VProfileImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(selectedImage: UIImage) {
        self.init(frame: .zero)
        
        image = selectedImage
        contentMode = .scaleToFill
    }
    
    func setSize(_ size: Double) {
        frame.size = CGSize(width: size, height: size)
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
    
    func setBorder(_ viewState: ViewState) {
        switch viewState {
        case .modify:
            layer.borderColor = UIColor._main.cgColor
            layer.borderWidth = Figure._border_lg
        case .noneModify:
            layer.borderColor = UIColor._main.cgColor
            layer.borderWidth = Figure._border_sm
        }
    }
    
    func setImage(_ image: ProfileImage) {
        self.image = UIImage(named: image.sourceName)
    }
    
    func isNotSelected() {
        layer.borderColor = UIColor._gray_sm.cgColor
        layer.borderWidth = Figure._border_sm
    }
    
    func isSelected() {
        layer.borderColor = UIColor._main.cgColor
        layer.borderWidth = Figure._border_lg
    }
}
