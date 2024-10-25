//
//  ReusableHeaderView.swift
//  ddonawa
//
//  Created by 강한결 on 10/25/24.
//

import UIKit

struct ReusableHeaderViewItem {
   let headerTitle: String
}

final class ReusableHeaderView: UICollectionReusableView {
   private let headerLabel = VLabel("", tType: .impact)
   
   func setViewItem(_ viewItem: ReusableHeaderViewItem) {
      self.addSubview(headerLabel)
      headerLabel.snp.makeConstraints { make in
         make.edges.equalTo(self.safeAreaLayoutGuide)
      }
      headerLabel.changeFont(._lgBold)
      headerLabel.changeLabelText(viewItem.headerTitle)
   }
}
