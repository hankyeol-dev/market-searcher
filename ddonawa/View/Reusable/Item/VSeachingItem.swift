//
//  VSeachingItem.swift
//  ddonawa
//
//  Created by 강한결 on 6/15/24.
//

import UIKit
import SnapKit
import Kingfisher

class VSeachingItem: UICollectionViewCell {
    private lazy var product: Product = Product(productId: "", title: "", mallName: "", productType: "", image: "", link: "", lprice: "")

    private let imgBack = UIView()
    private let img = UIImageView()
    private let pickButtonBack = UIView()
    private let pickButtonImg = UIImageView(image: UIImage.likeUnselected)
    
    private let mallLabel = VLabel("", tColor: ._gray_sm, tType: .sub)
    private let nameLabel = VLabel("", tType: .normal)
    private let priceLabel  = VLabel("", tType: .impact)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureImg()
        configureInfoBox()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension VSeachingItem {
    private func configureImg() {
        contentView.addSubview(imgBack)
        imgBack.addSubview(img)
        contentView.addSubview(pickButtonBack)
        pickButtonBack.addSubview(pickButtonImg)
        
        imgBack.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(88)
        }
        img.snp.makeConstraints {
            $0.edges.equalTo(imgBack.safeAreaLayoutGuide)
        }
        pickButtonBack.snp.makeConstraints {
            $0.trailing.bottom.equalTo(img.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(32)
        }
        pickButtonImg.snp.makeConstraints {
            $0.edges.equalTo(pickButtonBack.safeAreaLayoutGuide).inset(6)
        }
        
        
        imgBack.layer.cornerRadius = Figure._corner_searchingItemImg
        imgBack.clipsToBounds = true
        img.layer.cornerRadius = Figure._corner_searchingItemImg
        img.contentMode = .scaleAspectFill
        pickButtonBack.layer.cornerRadius = Figure._corner_searchingItemButton
        pickButtonBack.backgroundColor = ._gray_lg.withAlphaComponent(0.8)
        pickButtonImg.contentMode = .scaleAspectFit
        pickButtonImg.isUserInteractionEnabled = true
        
        pickButtonImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(togglePickButton)))
    }
    
    private func configureInfoBox() {
        [mallLabel, nameLabel, priceLabel].forEach {
            contentView.addSubview($0)
        }
        mallLabel.snp.makeConstraints {
            $0.top.equalTo(imgBack.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(mallLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
    }
}

extension VSeachingItem {
    func setItemWithData(_ data: Product) {
        self.product = data
        img.kf.setImage(with: URL(string: data.image))
        pickButtonBack.backgroundColor = User.getOrSaveUser.isInLiked(data.productId) ? ._white : ._gray_lg.withAlphaComponent(0.8)
        pickButtonImg.image = User.getOrSaveUser.isInLiked(data.productId) ? UIImage.likeSelected : UIImage.likeUnselected
        mallLabel.changeLabelText(data.mallName)
        nameLabel.changeLabelText(_replaceHTMLTag(data.title))
        nameLabel.numberOfLines = 2
        priceLabel.changeLabelText("\(_formatString(data.lprice))원")
    }
    
    @objc
    func togglePickButton() {
        var user = User.getOrSaveUser
        
        if !user.isInLiked(product.productId) {
            // 좋아요 하지 않은 상태
            // 일단 UI 변경해주고
            pickButtonBack.backgroundColor = .systemBackground
            pickButtonImg.image = UIImage.likeSelected
            
            // 좋아요 리스트에 넣어주고
            user.addLiked(
                ProductUserLiked(productId: product.productId, image: product.image, title: product.title, lprice: product.lprice, link: product.link)
            )
        } else {
            // 좋아요 했던 상태
            pickButtonBack.backgroundColor = ._gray_lg.withAlphaComponent(0.8)
            pickButtonImg.image = UIImage.likeUnselected
            
            user.deleteLiked(product.productId)
        }
        
        User.getOrSaveUser = user
    }
}
