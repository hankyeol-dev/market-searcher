//
//  VCOnboardingMain.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import UIKit

import SnapKit

class VCOnboardingMain: VCMain {
    
    private let logo = VLabel(Texts.APP_NAME.rawValue, tColor: ._main, tType: .logo)
    private let img = UIImageView(image: UIImage._launch)
    private let btn = VConfirmButton(Texts.Buttons.ONBOARDING_START.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubView()
        configureLayout()
        configureUI()
        configureAddAction()
    }
   
}

extension VCOnboardingMain {
    private func configureSubView() {
        view.addSubview(logo)
        view.addSubview(img)
        view.addSubview(btn)
    }
    
    private func configureLayout() {
        logo.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(120)
        }
        
        img.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.top.equalTo(logo.snp.bottom).offset(48)
        }
        
        btn.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(56)
        }
    }
    
    private func configureUI() {
        logo.changeAlignment(.center)
        img.contentMode = .scaleAspectFill
    }
    
    private func configureAddAction() {
        btn.addTarget(self, action: #selector(presentVC), for: .touchUpInside)
    }
}

extension VCOnboardingMain {
    @objc
    private func presentVC(_ sender: UIButton) {
        navigationController?.pushViewController(VCSettingProfile(), animated: true)
    }
}
