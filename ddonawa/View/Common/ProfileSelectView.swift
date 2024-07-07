//
//  ProfileSelectView.swift
//  ddonawa
//
//  Created by 강한결 on 7/1/24.
//

import UIKit
import SnapKit

class ProfileSelectView: BaseView {
    private let profile = VProfile(viewType: .onlyProfileImage, isNeedToRandom: false, imageArray: nil)
    private let cameraImg = VUpdateProfileImgButton()
    let cameraBtn = UIButton()
    let collection = {
        let l = UICollectionViewFlowLayout()

        let window = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let width = (window.screen.bounds.width - 80) / 4
        
        l.itemSize = CGSize(width: width, height: width)
        l.minimumLineSpacing = 16
        l.minimumInteritemSpacing = 16
        l.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        return UICollectionView(frame: .zero, collectionViewLayout: l)
    }()
    
    override func configureSubView() {
        super.configureSubView()
        
        [profile, cameraImg, collection].forEach {
            self.addSubview($0)
        }
        cameraImg.addSubview(cameraBtn)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        profile.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(Figure._profile_lg)
        }
        
        cameraImg.snp.makeConstraints {
            $0.centerX.equalTo(profile.snp.centerX).offset(44)
            $0.bottom.equalTo(profile.snp.bottom).inset(20)
            $0.size.equalTo(36)
        }
        
        cameraBtn.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collection.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(profile.snp.bottom)
        }
    }
    
    func setProfileImage(_ imageId: Int) {
        print(imageId)
        profile.setImage(_getProfileImageById(imageId))
    }
}
