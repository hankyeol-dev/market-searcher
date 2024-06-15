//
//  TCMain.swift
//  ddonawa
//
//  Created by 강한결 on 6/15/24.
//

import UIKit

class TCMain: UITabBarController {
    override func viewDidLoad() {
        configureUI()
        
        let searchVC = UINavigationController(rootViewController: VCSearchingMain())
        let settingVC = UINavigationController(rootViewController: VCSettingMain())
        searchVC.tabBarItem = UITabBarItem(title: Texts.Buttons.TABBAR_0.rawValue, image: Icons._search, tag: 0)
        settingVC.tabBarItem = UITabBarItem(title: Texts.Buttons.TABBAR_1.rawValue, image: Icons._user, tag: 1)
        
        setViewControllers([searchVC, settingVC], animated: true)
    }
    
    private func configureUI() {
        tabBar.tintColor = ._main
        tabBar.unselectedItemTintColor = ._gray_sm
        tabBar.backgroundColor = .systemBackground
    }
}
