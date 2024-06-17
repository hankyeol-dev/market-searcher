//
//  VCSettingMain.swift
//  ddonawa
//
//  Created by 강한결 on 6/15/24.
//

import UIKit
import SnapKit

class VCSettingMain: UIViewController {
    private let tableList = SettingTableList
    
    private let profile = VProfile(viewType: .withProfileInfo, isNeedToRandom: false, imageArray: nil)
    private let table = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNav(navTitle: Texts.Menu.SETTING.rawValue, left: nil, right: nil)
        configureView()
        configureTable()
    }
}

extension VCSettingMain {
    private func configureView() {
        view.addSubview(profile)
        profile.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Figure._profile_sm)
        }
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
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        table.rowHeight = 44
        table.separatorStyle = .singleLine
        table.separatorColor = ._gray_lg
        table.separatorInset = UIEdgeInsets(top: 4, left: 24, bottom: 4, right: 24)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: VSettingCell.id, for: indexPath) as! VSettingCell
        
        if indexPath.row == 0 {
            let likedCount = User.getOrSaveUser.getLiked.count
            cell.setCellWithData(tableList[0], sub: "\(likedCount)개의 상품")
        } else {
            cell.setCellWithData(tableList[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == tableList.count - 1 {
            table.reloadSections(IndexSet(integer: 0), with: .none)
            present(_showAlert(), animated: true)
        }
    }
}
