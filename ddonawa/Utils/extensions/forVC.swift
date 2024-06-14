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
    
    func configureNav(navTitle: String, left: UIBarButtonItem?, right: UIBarButtonItem?) {
        title = navTitle
        
        if let left {
            navigationItem.leftBarButtonItem = left
        }
        if let right {
            navigationItem.rightBarButtonItem = right
        }
    }
}

extension UIView: ID {
    static var id: String {
        return String(describing: self)
    }
}
