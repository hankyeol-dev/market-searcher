//
//  forAlert.swift
//  ddonawa
//
//  Created by 강한결 on 6/17/24.
//

import UIKit

func _showAlert() -> UIAlertController {
    let alert = UIAlertController(title: Texts.Alert.TITLE.rawValue, message: Texts.Alert.MESSAGE.rawValue, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: Texts.Alert.CONFIRM.rawValue, style: .default, handler: { action in
        // 탈퇴 로직
        User.deleteUser
        _dismissViewStack(UINavigationController(rootViewController: VCOnboardingMain()))
    }))
    alert.addAction(UIAlertAction(title: Texts.Alert.CANCEL.rawValue, style: .cancel))
    
    return alert
}
