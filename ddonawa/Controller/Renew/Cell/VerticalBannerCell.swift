//
//  VerticalBannerCell.swift
//  ddonawa
//
//  Created by 강한결 on 10/25/24.
//

import UIKit
import Combine

import SnapKit
import Kingfisher

struct VerticalSearchingViewItem: Hashable {
   var isLiked: Bool
   let item: Product
}

final class VerticalBannerCell: BaseCollectionViewCell {
   private weak var didTapLikeButton: PassthroughSubject<String, Never>?
   private var productId: String = ""
   
   private lazy var productImage: UIImageView = {
      let view = UIImageView()
      view.contentMode = .scaleToFill
      view.layer.cornerRadius = 8.0
      view.clipsToBounds = true
      return view
   }()
   private lazy var productLikeButton: UIButton = {
      let view = UIButton()
      view.backgroundColor = .clear
      view.setImage(.likeUnselected, for: .normal)
      view.addTarget(self, action: #selector(tapLikeButton), for: .touchUpInside)
      return view
   }()
   private lazy var productMall: UILabel = {
      let view = UILabel()
      view.font = .systemFont(ofSize: 10.0, weight: .regular)
      view.textColor = .lightGray
      return view
   }()
   private lazy var productName: VLabel = VLabel("", tType: .impact)
   private lazy var productPrice: VLabel = VLabel("", tType: .impact)
   
   override func setSubviews() {
      super.setSubviews()
      contentView.addSubviews(for: productImage, productMall, productName, productPrice, productLikeButton)
   }
   
   override func setLayouts() {
      super.setLayouts()
      productImage.snp.makeConstraints { make in
         make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
         make.height.equalTo(120.0)
      }
      productMall.snp.makeConstraints { make in
         make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
         make.top.equalTo(productImage.snp.bottom).offset(12.0)
      }
      productName.snp.makeConstraints { make in
         make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
         make.top.equalTo(productMall.snp.bottom).offset(5.0)
      }
      productPrice.snp.makeConstraints { make in
         make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
         make.top.equalTo(productName.snp.bottom).offset(8.0)
      }
      productLikeButton.snp.makeConstraints { make in
         make.trailing.equalTo(contentView.safeAreaLayoutGuide)
         make.top.equalTo(productPrice.snp.bottom).offset(8.0)
         make.size.equalTo(20.0)
      }
   }
   
   override func setViews() {
      super.setViews()
      productName.numberOfLines = 2
      productPrice.changeAlignment(.right)
   }
}

extension VerticalBannerCell {
   @objc
   func tapLikeButton(_ sender: UIButton) {
      didTapLikeButton?.send(productId)
   }
   
   func setViewItem(_ viewItem: VerticalSearchingViewItem, didTapLikeButton: PassthroughSubject<String, Never>) {
      self.didTapLikeButton = didTapLikeButton
      productId = viewItem.item.productId
      productImage.kf.setImage(with: URL(string: viewItem.item.image))
      productLikeButton.setImage(viewItem.isLiked ? .likeSelected : .likeUnselected,
                                 for: .normal)
      productMall.text = viewItem.item.mallName
      productName.changeLabelText(_replaceHTMLTag(viewItem.item.title))
      productPrice.changeLabelText(_formatString(viewItem.item.lprice) + "원")
   }
}

extension VerticalBannerCell {
   static func setCollectionHLayout() -> NSCollectionLayoutSection {
      let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0))
      let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
      
      let groupSize: NSCollectionLayoutSize = .init(widthDimension: .absolute(150.0),
                                                    heightDimension: .absolute(250.0))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])
      
      let section: NSCollectionLayoutSection = .init(group: group)
      section.orthogonalScrollingBehavior = .continuous
      section.contentInsets = .init(top: 15.0, leading: 20.0, bottom: 0.0, trailing: 20.0)
      section.interGroupSpacing = 20.0
      section.boundarySupplementaryItems = [
         .init(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50.0)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
      ]
      return section
   }
   
   static func setCollectionVLayout() -> NSCollectionLayoutSection {
      let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(0.48),
                                                   heightDimension: .absolute(250.0))
      let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
      item.contentInsets = .init(top: 0, leading: 10.0, bottom: 0, trailing: 10.0)
      
      let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(250.0))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])
      
      let section: NSCollectionLayoutSection = .init(group: group)
      section.orthogonalScrollingBehavior = .none
      section.contentInsets = .init(top: 10.0, leading: 20.0, bottom: 0.0, trailing: 20.0)
      section.interGroupSpacing = 20.0
      section.boundarySupplementaryItems = [
         .init(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50.0)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
      ]
      return section
   }
}
