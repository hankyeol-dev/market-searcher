//
//  forSegue.swift
//  ddonawa
//
//  Created by 강한결 on 6/17/24.
//

import UIKit

func _dismissViewStack(_ c: UIViewController) {
    let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    let sceneDelegate = scene?.delegate as? SceneDelegate
    
    let window = sceneDelegate?.window
    
    window?.rootViewController = c
    window?.makeKeyAndVisible()
}
