//
//  SeperatorViewCell.swift
//  ddonawa
//
//  Created by 강한결 on 10/25/24.
//

import UIKit
import SnapKit

struct SeperatorViewItem: Hashable {}

final class SeperatorViewCell: BaseCollectionViewCell {
   private let seperatorView: UIView = .init()
   
   override func setSubviews() {
      super.setSubviews()
      contentView.addSubview(seperatorView)
   }
   
   override func setLayouts() {
      super.setLayouts()
      seperatorView.snp.makeConstraints { make in
         make.edges.equalTo(contentView.safeAreaLayoutGuide)
      }
   }
   
   func setViewItem(_ viewItem: SeperatorViewItem) {
      seperatorView.backgroundColor = .systemGray5
   }
}

extension SeperatorViewCell {
   static func setCollectionLayout() -> NSCollectionLayoutSection {
      let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0))
      let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
      
      let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(10.0))
      let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                              subitems: [item])
      
      let section: NSCollectionLayoutSection = .init(group: group)
      return section
   }
}
