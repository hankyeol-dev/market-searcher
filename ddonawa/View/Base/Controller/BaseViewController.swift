//
//  BaseViewController.swift
//  ddonawa
//
//  Created by 강한결 on 7/1/24.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureSubView()
        configureLayout()
        configureView()
    }
    
    func configureSubView() {}
    func configureLayout() {}
    func configureView() {}
}

extension BaseViewController {
    func goSomeVC<T: UIViewController>(vc: T, vcHandler: @escaping (T) -> ()) {
        vcHandler(vc)
        navigationController?.pushViewController(vc, animated: true)
    }
}
