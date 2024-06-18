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
    private lazy var selectedImageId = 0
    private let profileImage = VProfileImage(selectedImage: UIImage.profile10)
    private let profileInfoStack = UIStackView()
    private let nameLabel = VLabel("asdf", tType: .impact)
    private let dateLabel = VLabel("asfdas", tColor: ._gray_md, tType: .normal)
    var editButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(viewType: ViewType, isNeedToRandom: Bool, imageArray: [ProfileImage]?) {
        self.init(frame: .zero)
        
        if isNeedToRandom {
            guard let imageArray else { return }
            let presentImage = RandomGenerator._getRandomElement(imageArray)
            selectedImageId = presentImage.id
            
            profileImage.setImage(presentImage)
        }
        
        configureView(viewType)
    }
}

extension VProfile {
    private func configureView(_ viewType: ViewType) {
        backgroundColor = .systemBackground
        addSubview(profileImage)
        
        switch viewType {
        case .onlyProfileImage:
            onlyProfileImage()
        case .withProfileInfo:
            withProfileInfo()
        }
        
    }
    
    private func onlyProfileImage() {
        profileImage.setSize(Figure._profileImg_lg)
        profileImage.setBorder(.modify)
        
        profileImage.snp.makeConstraints {
            $0.size.equalTo(Figure._profileImg_lg)
            $0.center.equalToSuperview()
        }
        
        profileImage.layer.borderColor = UIColor._main.cgColor
        profileImage.layer.borderWidth = Figure._border_lg
    }
    
    private func withProfileInfo() {
        profileImage.setSize(Figure._profileImg_sm)
        profileImage.setBorder(.noneModify)
        
        addSubview(profileInfoStack)
        profileInfoStack.addArrangedSubview(nameLabel)
        profileInfoStack.addArrangedSubview(dateLabel)
        addSubview(editButton)

        profileImage.snp.makeConstraints {
            $0.size.equalTo(Figure._profileImg_sm)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
        profileInfoStack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImage.snp.trailing).offset(24)
            $0.trailing.equalTo(editButton.snp.leading).inset(24)
        }
        editButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
        
        profileInfoStack.axis = .vertical
        profileInfoStack.spacing = 2
        profileInfoStack.distribution = .fillEqually
        nameLabel.changeFont(._xlBold)
        editButton.setImage(Icons._rightArrow, for: .normal)
        editButton.tintColor = ._gray_lg
        setUserData()
    }
    
    func setImage(_ profileImage: ProfileImage) {
        self.profileImage.image = UIImage(named: profileImage.sourceName)
    }
    
    func getPresentImage() -> Int {
        return selectedImageId
    }
    
    private func setUserData() {
        let user = User.getOrSaveUser
        profileImage.image = UIImage(named: user.getOrChangeImage.sourceName)
        nameLabel.changeLabelText(user.getOrChangeNick)
        dateLabel.changeLabelText("\(user.getSignedDate) 가입")
    }
}
