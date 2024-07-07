//
//  ProfileImageSelectViewController.swift
//  ddonawa
//
//  Created by 강한결 on 7/1/24.
//

import UIKit

final class ProfileImageSelectViewController: BaseViewController {
    var sender: (() -> ())?
    private var selectedId = 0
    
    private let mainView = ProfileSelectView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNav(navTitle: Texts.Navigations.ONBOARDING_PROFILE_SETTING.rawValue, left: _genLeftGoBackBarButton(), right: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sender?()
    }
}

extension ProfileImageSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func setCurrentProfileId(_ imageId: Int) {
        selectedId = imageId
        mainView.setProfileImage(selectedId)
    }
    
    func getCurrentProfileId() -> Int {
        selectedId
    }
    
    private func configureCollection() {
        let collection = mainView.collection
        collection.delegate = self
        collection.dataSource = self
        collection.register(VProfileImageItem.self, forCellWithReuseIdentifier: VProfileImageItem.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UIImage.profile.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: VProfileImageItem.id, for: indexPath) as? VProfileImageItem else { return UICollectionViewCell() }
        
        item.setProfileImage(
            _mappingProfileImageArrayBySelectedId(selectedId)[indexPath.row],
            isSelected: indexPath.row == selectedId
        )
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedId = indexPath.row
        
        mainView.setProfileImage(selectedId)
        collectionView.reloadSections(IndexSet(integer: 0))
    }
}
