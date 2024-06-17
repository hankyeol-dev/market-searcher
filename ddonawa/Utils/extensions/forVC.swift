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
        leftItem.tintColor = ._black
        
        return leftItem
    }
    
    enum RightBarButtonType {
        case image
        case title
    }
    
}

extension UIView: ID {
    static var id: String {
        return String(describing: self)
    }
}
