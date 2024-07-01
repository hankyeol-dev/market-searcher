//
//  OnboardingMainViewController.swift
//  ddonawa
//
//  Created by 강한결 on 7/1/24.
//

import UIKit

final class OnboardingMainViewController: BaseViewController {
    private let mainView = OnboardingMainView()
    
    override func loadView() {
        self.view = mainView
        mainView.addAction(object: mainView.btn, target: self, action: #selector(goNext), event: .touchUpInside)
    }
    
    @objc
    func goNext() {
        navigationController?.pushViewController(OnboardingProfileSettingViewController(), animated: true)
    }
}
