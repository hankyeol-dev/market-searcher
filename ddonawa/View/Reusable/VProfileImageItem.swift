//
//  VProfileImageItem.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import UIKit
import SnapKit

class VProfileImageItem: UICollectionViewCell {
    let item = VProfileImage(selectedImage: UIImage.profile0)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureImage()
    }
}

extension VProfileImageItem {
    func configureImage() {
        contentView.addSubview(item)
        
        item.setSize((UIScreen.main.bounds.width - 80) / 4)
        
        item.snp.makeConstraints {
            $0.size.equalTo((UIScreen.main.bounds.width - 80) / 4)
            $0.center.equalToSuperview()
        }
        
    }
    
    func setProfileImage(_ profileImage: ProfileImage, isSelected: Bool) {
        item.setImage(profileImage)
        switch isSelected {
        case true:
            item.isSelected()
        case false:
            item.isNotSelected()
        }
    }

}
