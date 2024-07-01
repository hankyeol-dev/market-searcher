//
//  BaseView.swift
//  ddonawa
//
//  Created by 강한결 on 7/1/24.
//

import UIKit
import SnapKit

class BaseView: UIView {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubView()
        configureLayout()
        configureView()
    }
    
    func configureSubView() {}
    func configureLayout() {}
    func configureView() {}
    
    func addAction<T: UIControl>(object: T, target: Any?, action: Selector, event: T.Event) {
        object.addTarget(target, action: action, for: event)
    }
}
