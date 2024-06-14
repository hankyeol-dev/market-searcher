//
//  ViewController.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import UIKit
import SnapKit

class VCSettingProfile: UIViewController {
    private let isSavedUser = User.isSavedUser
    private let profileView = VProfile(viewType: .onlyProfileImage)
    private let nickField = VUnderlinedTextField(Texts.Placeholders.ONBOARDING_NICK.rawValue)
    private let indicatingLabel = VIndicatingLabel()
    private let confirmButton = VButton(Texts.Buttons.ONBOARDING_CONFIRM.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
        configureTxF()
    }
    
}

extension VCSettingProfile {
    func configureNavigation() {
        let leftItem = UIBarButtonItem(image: Icons._leftArrow, style: .plain, target: self, action: #selector(goBack))
        leftItem.tintColor = .black
        configureNav(navTitle: Texts.Navigations.ONBOARDING_PROFILE_SETTING.rawValue, left: leftItem, right: nil)
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        
        view.addSubview(profileView)
        view.addSubview(nickField)
        view.addSubview(indicatingLabel)
        view.addSubview(confirmButton)
        
        profileView.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Figure._profile_lg)
        }
        
        nickField.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(40)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
        
        indicatingLabel.snp.makeConstraints {
            $0.top.equalTo(nickField.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(indicatingLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(56)
        }
    }
}

extension VCSettingProfile {
    @objc
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func endEditing() {
        nickField.endEditing(true)
        nickField.fieldOutFocus()
    }
}

extension VCSettingProfile: UITextFieldDelegate {
    private func configureTxF() {
        nickField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nickField.fieldOnFocus()
        indicatingLabel.startEditing()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        guard let text = textField.text else { return false }
        
        print("text: \(text)", "string: \(string)", "textCount: \(text.count)")
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                if text.count - 1 < 2 {
                    indicatingLabel.isLowerThanTwo()
                }
                return true
            }
        }
        
        if text.isEmpty {
            indicatingLabel.isEmpty()
            confirmButton.changeColorByDisabled()
        }
        
        if isContainsNumber(string) {
            indicatingLabel.isContainsNumber()
            confirmButton.changeColorByDisabled()
            return false
        }
        
        if isContainsSpecialLetter(string) {
            indicatingLabel.isContainsSpecialLetter()
            confirmButton.changeColorByDisabled()
            return false
        }
        
        if text.count + 1 > 10 {
            nickField.endEditing(true)
            return false
        }
        
        if text.count + 1 < 2 {
            indicatingLabel.isLowerThanTwo()
            confirmButton.changeColorByEnabled()
        } else {
            indicatingLabel.isSuccess()
            confirmButton.changeColorByEnabled()
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
