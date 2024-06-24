//
//  ViewController.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import UIKit
import SnapKit

class VCSettingProfile: VCMain {
    lazy var selectedImageId = 0
    
    private let profile = VProfile(
        viewType: .onlyProfileImage,
        isNeedToRandom: true,
        imageArray: _genProfileImageArray()
    )
    private let profileImgUpdateImg = VUpdateProfileImgButton()
    private let profileImageUpdateButton = UIButton()
    private let nicknameField = VUnderlinedTextField(Texts.Placeholders.ONBOARDING_NICK.rawValue)
    private let randomButton = UIButton()
    private let indicator = VIndicatingLabel()
    private let confirmButton = VConfirmButton(Texts.Buttons.ONBOARDING_CONFIRM.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubView()
        configureLayout()
        configureAddAction()
        configureConfirmButton()
        configureTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNav(navTitle: Texts.Navigations.ONBOARDING_PROFILE_SETTING.rawValue, left: _genLeftGoBackBarButton(), right: nil)
        
        if ProfileImage.getOrSetId != 0 {
            self.setSelectedImageId(ProfileImage.getOrSetId)
        }
    }
}

extension VCSettingProfile {
    
    func configureSubView() {
        [profile, profileImgUpdateImg, nicknameField, randomButton , indicator, confirmButton].forEach {
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
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
        
        randomButton.snp.makeConstraints {
            $0.top.equalTo(profile.snp.bottom).offset(40)
            $0.leading.equalTo(nicknameField.snp.trailing).offset(12)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
            $0.size.equalTo(100)
        }
        
        randomButton.configuration = ._roundFilledButton(Texts.Buttons.ONBOARDING_RANDOM_NICKNAME.rawValue)
        
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
        randomButton.addTarget(self, action: #selector(generateRandomProfile), for: .touchUpInside)
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
        
        configureNav(navTitle: Texts.Navigations.UPDATING_PROFILE_SETTING.rawValue, left: _genLeftGoBackBarButton(), right: rightSaveButton)
        
        setSelectedImageId(user.getOrChangeImage.id)
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
        vc.setProfileImage(_getProfileImageById(profile.getPresentImage()))
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func saveUser() {
        guard let nickname = nicknameField.text else { return }
        User.getOrSaveUser = User(
            nickname: nickname,
            image: ProfileImage(
                id: selectedImageId,
                sourceName: _getProfileImageById(selectedImageId).sourceName))
        _dismissViewStack(TCMain())
    }
    
    @objc
    func updateUser() {
        guard let nickname = nicknameField.text else { return }
        var user = User.getOrSaveUser
        user.getOrChangeNick = nickname
        user.getOrChangeImage = ProfileImage(
            id: selectedImageId,
            sourceName: _getProfileImageById(selectedImageId).sourceName
        )
        
        User.getOrSaveUser = user
        
        let tc = TCMain()
        tc.selectedIndex = 1
        
        _dismissViewStack(tc)
    }
    
    @objc
    func generateRandomProfile() {
        let nick = RandomGenerator._getRandomNick()
        let img = RandomGenerator._getRandomElement(_genProfileImageArray())
       
        nicknameField.text = nick
        profile.setImage(img)
        selectedImageId = img.id
        
        indicator.isSuccess()
        confirmButton.changeColorByEnabled()
    }
    
    func setSelectedImageId(_ id: Int) {
        selectedImageId = id
        profile.setImage(_getProfileImageById(selectedImageId))
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {return}
        
        do {
            try NickValidationService.validateNickname(text)
            
            indicator.isSuccess()
            confirmButton.changeColorByEnabled()
            
        } catch NickValidationService.Errors.isEmpty {
            indicator.isEmpty()
            confirmButton.changeColorByDisabled()
        } catch NickValidationService.Errors.isLowerThanTwo {
            indicator.isLowerThanTwoOrOverTen()
            confirmButton.changeColorByDisabled()
        } catch NickValidationService.Errors.isContainNumber {
            indicator.isContainsNumber()
            confirmButton.changeColorByDisabled()
        } catch NickValidationService.Errors.isContainSpecialLetter {
            indicator.isContainsSpecialLetter()
            confirmButton.changeColorByDisabled()
        } catch NickValidationService.Errors.isOverTen {
            indicator.isLowerThanTwoOrOverTen()
            confirmButton.changeColorByDisabled()
        } catch {
            confirmButton.changeColorByDisabled()
        }
    }
}
