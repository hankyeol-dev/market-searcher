//
//  VRecentSearchCell.swift
//  ddonawa
//
//  Created by 강한결 on 6/15/24.
//

import UIKit
import SnapKit

class VRecentSearchCell: UITableViewCell {
    lazy var cellIndex: Int = 0
    
    let back = UIView()
    let img = UIImageView(image: Icons._clock)
    let search = VLabel("", tType: .normal)
    let btn = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewAndLayout()
        configureCellUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension VRecentSearchCell {
    private func configureViewAndLayout() {
        contentView.addSubview(back)
        [img, search, btn].forEach {
            back.addSubview($0)
        }
        
        back.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(4)
        }
        img.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalTo(back.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(12)
        }
        search.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalTo(img.snp.trailing).offset(12)
        }
        btn.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalTo(search.snp.trailing).inset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(16)
        }
    }
    
    private func configureCellUI() {
        back.backgroundColor = .systemBackground
        img.contentMode = .center
        img.tintColor = ._black
        btn.setImage(Icons._delete, for: .normal)
        btn.tintColor = ._black
    }
    
    func setCellWithData(_ searchText: String, cellIndex: Int) {
        search.changeLabelText(searchText)
        self.cellIndex = cellIndex
    }

}
