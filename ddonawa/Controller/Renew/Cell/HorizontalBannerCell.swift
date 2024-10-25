//
//  HorizontalBannerCell.swift
//  ddonawa
//
//  Created by 강한결 on 10/25/24.
//

import UIKit

import SnapKit
import Kingfisher

struct HorizontalBannerCellItem: Hashable {
   let imageURL: String
}

final class HorizontalBannerCell: BaseCollectionViewCell {
   private let bannerImage: UIImageView = {
      let view = UIImageView()
      view.contentMode = .scaleToFill
      return view
   }()
   
   override func setSubviews() {
      super.setSubviews()
      contentView.addSubview(bannerImage)
   }
   
   override func setLayouts() {
      super.setLayouts()
      bannerImage.snp.makeConstraints { make in
         make.edges.equalTo(contentView.safeAreaLayoutGuide)
      }
   }
   
   override func setViews() {
      super.setViews()
   }
   
   func setViewItem(_ viewItem: HorizontalBannerCellItem) {
      bannerImage.kf.setImage(with: URL(string: viewItem.imageURL))
   }
}

extension HorizontalBannerCell {
   static func setCellLayout() -> NSCollectionLayoutSection {
      let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0))
      let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
      
      let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .fractionalHeight(0.4))
      
      let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                              subitems: [item])
      
      let section: NSCollectionLayoutSection = .init(group: group)
      section.orthogonalScrollingBehavior = .groupPaging      
      
      return section
   }
}
