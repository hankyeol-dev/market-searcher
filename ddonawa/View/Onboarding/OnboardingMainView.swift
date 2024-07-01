//
//  OnboardingMainView.swift
//  ddonawa
//
//  Created by 강한결 on 7/1/24.
//

import UIKit
import SnapKit

final class OnboardingMainView: BaseView {
    private let logo = VLabel(Texts.APP_NAME.rawValue, tColor: ._main, tType: .logo)
    private let img = UIImageView(image: UIImage._launch)
    let btn = VConfirmButton(Texts.Buttons.ONBOARDING_START.rawValue)
    
    override func configureSubView() {
        super.configureSubView()
        [logo, img, btn].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        super.configureLayout()
        let guide = self.safeAreaLayoutGuide
        
        logo.snp.makeConstraints {
            $0.horizontalEdges.equalTo(guide).inset(24)
            $0.top.equalTo(guide).inset(120)
        }
        
        img.snp.makeConstraints {
            $0.horizontalEdges.equalTo(guide).inset(24)
            $0.top.equalTo(logo.snp.bottom).offset(48)
        }
        
        btn.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(guide).inset(20)
            $0.height.equalTo(56)
        }
    }
    
    override func configureView() {
        logo.changeAlignment(.center)
        img.contentMode = .scaleAspectFill
    }
}
