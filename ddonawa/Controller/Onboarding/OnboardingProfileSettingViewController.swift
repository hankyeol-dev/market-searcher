//
//  OnboardingProfileSettingViewController.swift
//  ddonawa
//
//  Created by 강한결 on 7/1/24.
//

import UIKit

final class OnboardingProfileSettingViewController: BaseViewController {
    private var currentImageId: Int = -1
    
    private let mainView = OnboardingProfileSetting()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAddAction()
        configureTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNav(navTitle: Texts.Navigations.ONBOARDING_PROFILE_SETTING.rawValue, left: _genLeftGoBackBarButton(), right: nil)
        if ProfileImage.getOrSetId != 0 {
            self.setSelectedImageId(ProfileImage.getOrSetId)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.setSelectedImageId(currentImageId)
    }
}

extension OnboardingProfileSettingViewController {
    private func setSelectedImageId(_ id: Int) {
        currentImageId = id
        mainView.profile.setImage(_getProfileImageById(currentImageId))
    }
    
    @objc
    func goSelectVC() {
        goSomeVC(vc: VCSelectProfileImage()) { vc in
            vc.setProfileImage(_getProfileImageById(self.currentImageId))
        }
    }
    
    @objc
    func genRandomProfile() {
        let nick = RandomGenerator._getRandomNick()
        let img = RandomGenerator._getRandomElement(_genProfileImageArray())
        
        self.currentImageId = img.id
        mainView.field.text = nick
        mainView.profile.setImage(img)
        mainView.indicatingLabel.isSuccess()
        mainView.confirmBtn.changeColorByEnabled()
    }
    
    @objc
    func saveUser() {
        guard let text = mainView.field.text else { return }
        User.getOrSaveUser = User(
            nickname: text,
            image: ProfileImage(
                id: currentImageId,
                sourceName: _getProfileImageById(currentImageId).sourceName))
        _dismissViewStack(MainTabBarController())
    }
    
    @objc
    func endFieldEditing() {
        mainView.endEditing(true)
        mainView.field.fieldOutFocus()
    }
    
    func configureAddAction() {
        mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endFieldEditing)))
        mainView.addAction(object: mainView.cameraBtn, target: self, action: #selector(goSelectVC), event: .touchUpInside)
        mainView.addAction(object: mainView.randomBtn, target: self, action: #selector(genRandomProfile), event: .touchUpInside)
        
        if mainView.confirmBtn.isEnabled {
            mainView.addAction(object: mainView.confirmBtn, target: self, action: #selector(saveUser), event: .touchUpInside)
        }
    }
}

extension OnboardingProfileSettingViewController: UITextFieldDelegate {
    private func configureTextField() {
        mainView.field.delegate = self
        mainView.confirmBtn.changeColorByDisabled()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        mainView.field.fieldOnFocus()
        mainView.indicatingLabel.startEditing()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let indicator = mainView.indicatingLabel
        let confirmBtn = mainView.confirmBtn
        
        do {
            try ValidateService.validateNickname(text)
            
            indicator.isSuccess()
            confirmBtn.changeColorByEnabled()
            
        } catch ValidateService.Errors.isEmpty {
            indicator.isEmpty()
            confirmBtn.changeColorByDisabled()
        } catch ValidateService.Errors.isLowerThanTwo {
            indicator.isLowerThanTwoOrOverTen()
            confirmBtn.changeColorByDisabled()
        } catch ValidateService.Errors.isContainNumber {
            indicator.isContainsNumber()
            confirmBtn.changeColorByDisabled()
        } catch ValidateService.Errors.isContainSpecialLetter {
            indicator.isContainsSpecialLetter()
            confirmBtn.changeColorByDisabled()
        } catch ValidateService.Errors.isOverTen {
            indicator.isLowerThanTwoOrOverTen()
            confirmBtn.changeColorByDisabled()
        } catch {
            confirmBtn.changeColorByDisabled()
        }
    }
}
