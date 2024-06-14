//
//  VCSelectProfileImage.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import UIKit
import SnapKit

class VCSelectProfileImage: UIViewController {
    private lazy var selectedId = 0
    
    private let profileView = VProfile(viewType: .onlyProfileImage, isNeedToRandom: false, imageArray: nil)
    private let profileImageUpdateView = VButtonUpdateImage()
    private let profileImageUpdateButton = UIButton()
    private let profileImageCollection = {
        let l = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 80) / 4
        l.itemSize = CGSize(width: width, height: width)
        l.minimumLineSpacing = 16
        l.minimumInteritemSpacing = 16
        l.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return UICollectionView(frame: .zero, collectionViewLayout: l)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigation()
        configureSubView()
        configureLayout()
        configureCollection()
    }
}

extension VCSelectProfileImage {
    func configureNavigation() {
        let leftItem = UIBarButtonItem(image: Icons._leftArrow, style: .plain, target: self, action: #selector(goBack))
        leftItem.tintColor = ._black
        configureNav(navTitle: Texts.Navigations.ONBOARDING_PROFILE_SETTING.rawValue, left: leftItem, right: nil)
    }
    func configureSubView() {
        view.addSubview(profileView)
        view.addSubview(profileImageUpdateView)
        profileImageUpdateView.addSubview(profileImageUpdateButton)
        view.addSubview(profileImageCollection)
    }
    func configureLayout() {
        profileView.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Figure._profile_lg)
        }
        
        profileImageUpdateView.snp.makeConstraints {
            $0.centerX.equalTo(profileView.snp.centerX).offset(44)
            $0.bottom.equalTo(profileView.snp.bottom).inset(20)
            $0.size.equalTo(36)
        }
        
        profileImageUpdateButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        profileImageCollection.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(profileView.snp.bottom)
        }
    }
}

extension VCSelectProfileImage {
    func setProfileImage(_ profileImage: ProfileImage) {
        selectedId = profileImage.id
        profileView.setImage(profileImage)
    }
    
    @objc
    override func goBack() {
        UserDefaults.standard.setValue(selectedId, forKey: "selectedId")
        navigationController?.popViewController(animated: true)
    }
}

extension VCSelectProfileImage: UICollectionViewDelegate, UICollectionViewDataSource {
    func configureCollection() {
        profileImageCollection.delegate = self
        profileImageCollection.dataSource = self
        profileImageCollection.register(VProfileImageItem.self, forCellWithReuseIdentifier: VProfileImageItem.id)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UIImage.profile.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = profileImageCollection.dequeueReusableCell(withReuseIdentifier: VProfileImageItem.id, for: indexPath) as! VProfileImageItem
        
        item.setProfileImage(
            mappingProfileImageArrayBySelectedId(selectedId)[indexPath.row],
            isSelected: indexPath.row == selectedId
        )
        
        return item
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedId = indexPath.row
        
        profileView.setImage(getProfileImageById(selectedId))
        profileImageCollection.reloadSections(IndexSet(integer: 0))
    }
}
