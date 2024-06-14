//
//  VCOnboardingMain.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import UIKit

import SnapKit

class VCOnboardingMain: UIViewController {
    
    private let logo = VLogo(Texts.APP_NAME.rawValue)
    private lazy var img = {
        let i = UIImageView(image: ._launch)
        i.contentMode = .scaleAspectFill
        return i
    }()
    private let btn = VButton(Texts.Buttons.ONBOARDING_START.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureSubView()
        configureLayout()
        configureAction()
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
}

extension VCOnboardingMain {
    func configureAction() {
        btn.addTarget(self, action: #selector(presentVC), for: .touchUpInside)
    }
    
    @objc
    func presentVC(_ sender: UIButton) {
        navigationController?.pushViewController(VCSettingProfile(), animated: true)
    }
}
