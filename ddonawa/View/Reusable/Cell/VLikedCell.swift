//
//  VLikedCell.swift
//  ddonawa
//
//  Created by 강한결 on 6/24/24.
//

import UIKit
import SnapKit

class VLikedCell: UITableViewCell {
    
    private lazy var product: ProductUserLiked = ProductUserLiked(productId: "", image: "", title: "", lprice: "", link: "")
    
    private let image = UIImageView()
    private let vStack = UIStackView()
    private let title = VLabel("", tType: .normal)
    private let price = VLabel("", tType: .impact)
    var button = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewAndLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension VLikedCell {
    private func configureViewAndLayout() {
        [image, vStack, button].forEach {
            contentView.addSubview($0)
        }
        [title, price].forEach {
            vStack.addArrangedSubview($0)
        }
        
        let guide = contentView.safeAreaLayoutGuide
        
        image.snp.makeConstraints {
            $0.verticalEdges.leading.equalTo(guide).inset(12)
            $0.size.equalTo(44)
        }
        
        vStack.snp.makeConstraints {
            $0.verticalEdges.equalTo(guide).inset(10)
            $0.leading.equalTo(image.snp.trailing).offset(12)
            $0.height.equalTo(44)
            $0.width.equalTo(200)
        }
        
        button.snp.makeConstraints {
            $0.top.trailing.equalTo(guide).inset(12)
            $0.size.equalTo(16)
        }
        
    }
    
    private func configureUI() {
        vStack.axis = .vertical
        vStack.spacing = 4
        vStack.distribution = .fillEqually
        button.setImage(Icons._delete, for: .normal)
        button.tintColor = ._gray_lg
    }
    
    func setCellWithData(_ data: ProductUserLiked) {
        product = data
        
        image.kf.setImage(with: URL(string: data.image)!)
        title.changeLabelText(_replaceHTMLTag(data.title))
        price.changeLabelText("\(_formatString(data.lprice))원")
    }
}
