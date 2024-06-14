//
//  VProfile.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import UIKit

import SnapKit

enum ViewType {
    case onlyProfileImage
    case withProfileInfo
}

class VProfile: UIView {
    private var profileImage = VProfileImage(selectedImage: UIImage.profile10)
    private let profileImageUpdateButton = VButtonUpdateImage()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(viewType: ViewType) {
        self.init(frame: .zero)
        self.profileImage.image =  UIImage(named: getRandomElement(UIImage.profile.allCases).rawValue) ?? UIImage.profile0
        configureView(viewType)
    }
}

extension VProfile {
    func configureView(_ viewType: ViewType) {
        backgroundColor = .systemBackground
        addSubview(profileImage)

        switch viewType {
        case .onlyProfileImage:
            onlyProfileImage()
        case .withProfileInfo:
            withProfileInfo()
        }

    }
    
    func onlyProfileImage() {
        addSubview(profileImageUpdateButton)
        
        profileImage.setSize(Figure._profileImg_lg)
        profileImage.setBorder(.modify)
        
        profileImage.snp.makeConstraints {
            $0.size.equalTo(Figure._profileImg_lg)
            $0.center.equalToSuperview()
        }
        
        profileImageUpdateButton.snp.makeConstraints {
            $0.centerX.equalTo(profileImage.snp.trailing).inset(12)
            $0.bottom.equalTo(profileImage.snp.bottom)
            $0.size.equalTo(36)
        }
        
        profileImage.layer.borderColor = UIColor._main.cgColor
        profileImage.layer.borderWidth = Figure._border_lg
    }
    
    func withProfileInfo() {
        profileImage.setSize(Figure._profileImg_sm)
        profileImage.setBorder(.noneModify)
        
        profileImage.snp.makeConstraints {
            $0.size.equalTo(Figure._profileImg_sm)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
        
    }
    
    func setImage(_ imageName: UIImage.profile.RawValue) {
        profileImage.image = UIImage(named: imageName)
    }
}
