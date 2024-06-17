//
//  VSettingCell.swift
//  ddonawa
//
//  Created by 강한결 on 6/17/24.
//

import UIKit
import SnapKit

class VSettingCell: UITableViewCell {
    
    private let cellTitle = VLabel("", tType: .normal)
    private let celllSubTitle = VLabel("", tType: .normal)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VSettingCell {
    private func configureView() {
        contentView.addSubview(cellTitle)
        contentView.addSubview(celllSubTitle)
        
        cellTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).inset(24)
        }
        celllSubTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(24)
        }
    }
    
    
    func setSettingCellWithData(_ title: String, sub: String = "") {
        cellTitle.changeLabelText(title)
        celllSubTitle.changeLabelText(sub)
    }
    
}
