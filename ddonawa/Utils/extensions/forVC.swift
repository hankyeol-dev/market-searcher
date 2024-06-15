//
//  forVC.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import UIKit

protocol ID {
    static var id: String { get }
}

extension UIViewController: ID {
    static var id: String {
        return String(describing: self)
    }
    
    @objc
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureNav(navTitle: String, left: UIBarButtonItem?, right: UIBarButtonItem?) {
        navigationItem.title = navTitle
        
        if let left {
            navigationItem.leftBarButtonItem = left
        }
        if let right {
            navigationItem.rightBarButtonItem = right
        }
    }
    
    func genLeftGoBackBarButton() -> UIBarButtonItem {
        let leftItem = UIBarButtonItem(image: Icons._leftArrow, style: .plain, target: self, action: #selector(goBack))
        leftItem.tintColor = .black
        
        return leftItem
    }
    
    func dismissViewStack(_ vc: UIViewController) {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = scene?.delegate as? SceneDelegate
        
        let window = sceneDelegate?.window
        
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
    }
}

extension UIView: ID {
    static var id: String {
        return String(describing: self)
    }
}
