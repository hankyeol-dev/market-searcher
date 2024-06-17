//
//  VCSettingMain.swift
//  ddonawa
//
//  Created by 강한결 on 6/15/24.
//

import UIKit
import SnapKit

class VCSettingMain: VCMain {
    private lazy var likedCount = User.getOrSaveUser.getLiked.count
    private let tableList = SettingTableList
    
    private let profile = VProfile(viewType: .withProfileInfo, isNeedToRandom: false, imageArray: nil)
    private let table = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureProfileView()
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureNav(navTitle: Texts.Menu.SETTING.rawValue, left: nil, right: nil)
        likedCount = User.getOrSaveUser.getLiked.count
        table.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
}

extension VCSettingMain {
    private func configureProfileView() {
        view.addSubview(profile)
        profile.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Figure._profile_sm)
        }
        profile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchProfileView)))
    }
    
    @objc
    func touchProfileView() {
        let vc = VCSettingProfile()
        vc.configureViewAtUpdate()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension VCSettingMain: UITableViewDelegate, UITableViewDataSource {
    private func configureTable() {
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.register(VSettingCell.self, forCellReuseIdentifier: VSettingCell.id)
        
        table.snp.makeConstraints {
            $0.top.equalTo(profile.snp.bottom).offset(4)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        table.separatorStyle = .singleLine
        table.separatorColor = ._gray_lg
        table.separatorInset = UIEdgeInsets(top: 4, left: 24, bottom: 4, right: 24)
        table.rowHeight = 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: VSettingCell.id, for: indexPath) as! VSettingCell
        
        if indexPath.row == 0 {
            cell.setSettingCellWithData(tableList[0], sub: "\(likedCount)개의 상품")
        } else {
            cell.setSettingCellWithData(tableList[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == tableList.count - 1 {
            present(_showAlert(), animated: true)
            table.reloadSections(IndexSet(integer: 0), with: .none)
        }
    }
}
