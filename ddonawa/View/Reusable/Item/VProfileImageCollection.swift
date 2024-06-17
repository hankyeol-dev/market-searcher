//
//  VProfileImageCollection.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import UIKit

class VProfileImageCollection: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VProfileImageCollection {
     func configureLayout() {
        let l = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 80 / 4
        l.itemSize = CGSize(width: width, height: width)
        l.minimumLineSpacing = 16
        l.minimumInteritemSpacing = 16
        l.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        self.collectionViewLayout = l
    }
}
