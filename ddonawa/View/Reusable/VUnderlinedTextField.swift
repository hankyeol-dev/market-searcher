//
//  VUnderlinedTxf.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import UIKit

import SnapKit

class VUnderlinedTextField: UITextField {
    private let underline = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ placeholderText: String = "") {
        self.init(frame: .zero)
        
        configureField(placeholderText)
        configureUnderline()
        
    }
}

extension VUnderlinedTextField {
    func configureField(_ placeholderText: String) {
        backgroundColor = .systemBackground
        textColor = ._black
        tintColor = ._main
        placeholder = placeholderText
        leftView = UIView(frame: CGRect(x: 0, y: 4, width: 4, height: self.frame.height))
        leftViewMode = .always
    }
    
    func configureUnderline() {
        addSubview(underline)
        
        underline.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        underline.layer.borderColor = UIColor._gray_md.cgColor
        underline.layer.borderWidth = 1
    }
    
    func fieldOnFocus() {
        underline.layer.borderColor = UIColor._main.cgColor
    }
    
    func fieldOutFocus() {
        underline.layer.borderColor = UIColor._gray_md.cgColor
    }
    
    func fieldOnError() {
        underline.layer.borderColor = UIColor._tint_error.cgColor
    }

}
