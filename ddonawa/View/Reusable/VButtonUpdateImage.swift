//
//  VButtonUpdateImage.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import UIKit
import SnapKit

class VButtonUpdateImage: UIView {
    
    let cameraBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame.size = CGSize(width: 36, height: 36)
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
        backgroundColor = ._main
        
        addSubview(cameraBtn)
        
        cameraBtn.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(6)
        }
        
        cameraBtn.setImage(Icons._camera, for: .normal)
        cameraBtn.backgroundColor = .clear
        cameraBtn.tintColor = ._white
    }

}
