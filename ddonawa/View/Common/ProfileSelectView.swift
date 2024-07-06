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
    let cameraImg = VUpdateProfileImgButton()
    let cameraBtn = UIButton()
}
