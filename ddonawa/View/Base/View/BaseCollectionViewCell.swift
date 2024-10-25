//
//  BaseCollectionViewCell.swift
//  ddonawa
//
//  Created by 강한결 on 10/25/24.
//

import UIKit

protocol BaseCollectionViewCellProvider {
   func setSubviews()
   func setLayouts()
   func setViews()
}

class BaseCollectionViewCell: UICollectionViewCell, BaseCollectionViewCellProvider {
   override init(frame: CGRect) {
      super.init(frame: frame)
      setSubviews()
      setLayouts()
      setViews()
   }
   
   @available(*, unavailable)
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   func setSubviews() {}
   func setLayouts() {}
   func setViews() {}
}
