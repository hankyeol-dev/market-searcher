//
//  ViewController.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import UIKit
import SnapKit

class VCSettingProfile: VCMain {
    var userSelectedId: Int?
    lazy var selectedImageId = 0
    private let isSavedUser = User.isSavedUser
    
    private let profile = VProfile(
        viewType: .onlyProfileImage,
        isNeedToRandom: true,
        imageArray: genProfileImageArray()
    )
    private let profileImgUpdateImg = VUpdateProfileImgButton()
    private let profileImageUpdateButton = UIButton()
    private let nicknameField = VUnderlinedTextField(Texts.Placeholders.ONBOARDING_NICK.rawValue)
    private let indicator = VIndicatingLabel()
    private let confirmButton = VConfirmButton(Texts.Buttons.ONBOARDING_CONFIRM.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubView()
        configureLayout()
        configureAddAction()
        configureTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNav(navTitle: Texts.Navigations.ONBOARDING_PROFILE_SETTING.rawValue, left: genLeftGoBackBarButton(), right: nil)
        
        if ProfileImage.getOrSetId != 0 {
            self.setSelectedImageId(ProfileImage.getOrSetId)
        }
    }
}

extension VCSettingProfile {
    
    func configureSubView() {
        [profile, profileImgUpdateImg, nicknameField, indicator, confirmButton].forEach {
            view.addSubview($0)
        }
        profileImgUpdateImg.addSubview(profileImageUpdateButton)
    }
    
    private func configureLayout() {
        profile.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Figure._profile_lg)
        }
        
        profileImgUpdateImg.snp.makeConstraints {
            $0.centerX.equalTo(profile.snp.centerX).offset(44)
            $0.bottom.equalTo(profile.snp.bottom).inset(20)
            $0.size.equalTo(36)
        }
        
        profileImageUpdateButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        nicknameField.snp.makeConstraints {
            $0.top.equalTo(profile.snp.bottom).offset(40)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
        
        indicator.snp.makeConstraints {
            $0.top.equalTo(nicknameField.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(indicator.snp.bottom).offset(40)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(56)
        }
    }
    
    private func configureAddAction() {
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        profileImageUpdateButton.addTarget(self, action: #selector(presentProfileImageSelectVC), for: .touchUpInside)
    }
    
    
    private func configureConfirmButton() {
        if confirmButton.isEnabled {
            confirmButton.addTarget(self, action: #selector(saveUser), for: .touchUpInside)
        }
    }
    
    func configureViewAtUpdate() {
        let user = User.getOrSaveUser
        let rightSaveButton = UIBarButtonItem(title: Texts.Buttons.NAVIGATION_SAVE.rawValue, style: .plain, target: self, action: #selector(updateUser))
        rightSaveButton.tintColor = ._black
        
        configureNav(navTitle: Texts.Navigations.UPDATING_PROFILE_SETTING.rawValue, left: genLeftGoBackBarButton(), right: rightSaveButton)
        
        nicknameField.text = user.getOrChangeNick
        confirmButton.isHidden = true
    }
}

extension VCSettingProfile {
    @objc
    func endEditing() {
        nicknameField.endEditing(true)
        nicknameField.fieldOutFocus()
    }
    
    @objc
    func presentProfileImageSelectVC() {
        let vc = VCSelectProfileImage()
        vc.setProfileImage(getProfileImageById(profile.getPresentImage()))
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func saveUser() {
        guard let nickname = nicknameField.text else { return }
        User.getOrSaveUser = User(
            nickname: nickname,
            image: ProfileImage(
                id: selectedImageId,
                sourceName: getProfileImageById(selectedImageId).sourceName))
        _dismissViewStack(TCMain())
    }
    
    @objc
    func updateUser() {
        guard let nickname = nicknameField.text else { return }
        var user = User.getOrSaveUser
        user.getOrChangeNick = nickname
        user.getOrChangeImage = ProfileImage(
            id: selectedImageId,
            sourceName: getProfileImageById(selectedImageId).sourceName)
        
        User.getOrSaveUser = user
        
        let tc = TCMain()
        tc.selectedIndex = 1
        
        _dismissViewStack(tc)
    }
    
    func setSelectedImageId(_ id: Int) {
        selectedImageId = id
        profile.setImage(getProfileImageById(selectedImageId))
    }
}

extension VCSettingProfile: UITextFieldDelegate {
    private func configureTextField() {
        nicknameField.delegate = self
        confirmButton.changeColorByDisabled()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nicknameField.fieldOnFocus()
        indicator.startEditing()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                if text.count - 1 < 2 {
                    indicator.isLowerThanTwo()
                    confirmButton.changeColorByDisabled()
                }
                return true
            }
        }
        
        if text.isEmpty {
            indicator.isEmpty()
            confirmButton.changeColorByDisabled()
        }
        
        if isContainsNumber(string) {
            indicator.isContainsNumber()
            confirmButton.changeColorByDisabled()
            return false
        }
        
        if isContainsSpecialLetter(string) {
            indicator.isContainsSpecialLetter()
            confirmButton.changeColorByDisabled()
            return false
        }
        
        if text.count + 1 > 10 {
            nicknameField.endEditing(true)
            return false
        }
        
        if text.count + 1 < 2 {
            indicator.isLowerThanTwo()
            confirmButton.changeColorByDisabled()
        } else {
            indicator.isSuccess()
            confirmButton.changeColorByEnabled()
            configureConfirmButton()
        }
        return true
    }
    
    
    private func isContainsSpecialLetter(_ c: String) -> Bool {
        return c == "@" || c == "#" || c == "$" || c == "%"
    }
    
    private func isContainsNumber(_ c: String) -> Bool {
        return Int(c) != nil
    }
}
