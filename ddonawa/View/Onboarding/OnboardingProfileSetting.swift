//
//  OnboardingProfileSetting.swift
//  ddonawa
//
//  Created by 강한결 on 7/1/24.
//

import UIKit
import SnapKit

final class OnboardingProfileSetting: BaseView {
    
    let profile = VProfile(
        viewType: .onlyProfileImage,
        isNeedToRandom: true,
        imageArray: _genProfileImageArray()
    )
    private let cameraImg = VUpdateProfileImgButton()
    let field = VUnderlinedTextField(Texts.Placeholders.ONBOARDING_NICK.rawValue)
    let indicatingLabel = VIndicatingLabel()
    let cameraBtn = UIButton()
    let randomBtn = UIButton()
    let confirmBtn = VConfirmButton(Texts.Buttons.ONBOARDING_CONFIRM.rawValue)
    
    override func configureSubView() {
        super.configureSubView()
        
        [profile, cameraImg, field, randomBtn, indicatingLabel, confirmBtn].forEach {
            self.addSubview($0)
        }
        cameraImg.addSubview(cameraBtn)
    }
    
    override func configureLayout() {
        super.configureLayout()
        let guide = self.safeAreaLayoutGuide
        
        profile.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(guide)
            $0.height.equalTo(Figure._profile_lg)
        }
        
        cameraImg.snp.makeConstraints {
            $0.centerX.equalTo(profile.snp.centerX).offset(44)
            $0.bottom.equalTo(profile.snp.bottom).inset(20)
            $0.size.equalTo(36)
        }
        
        cameraBtn.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        field.snp.makeConstraints {
            $0.top.equalTo(profile.snp.bottom).offset(40)
            $0.leading.equalTo(guide).inset(16)
            $0.height.equalTo(44)
        }
        
        randomBtn.snp.makeConstraints {
            $0.top.equalTo(profile.snp.bottom).offset(40)
            $0.leading.equalTo(field.snp.trailing).offset(12)
            $0.trailing.equalTo(guide).inset(16)
            $0.height.equalTo(44)
            $0.size.equalTo(100)
        }
        
        indicatingLabel.snp.makeConstraints {
            $0.top.equalTo(field.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(guide).inset(16)
        }
        
        confirmBtn.snp.makeConstraints {
            $0.top.equalTo(indicatingLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalTo(guide).inset(16)
            $0.height.equalTo(56)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        randomBtn.configuration = ._roundFilledButton(Texts.Buttons.ONBOARDING_RANDOM_NICKNAME.rawValue)
    }

}
