//
//  VCSettingMain.swift
//  ddonawa
//
//  Created by 강한결 on 6/15/24.
//

import UIKit

class VCSettingMain: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNav(navTitle: Texts.Menu.SETTING.rawValue, left: nil, right: nil)
    }
}
