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
    
    private let table = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNav(navTitle: Texts.Menu.SETTING.rawValue, left: nil, right: nil)
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        table.reloadSections(IndexSet(integer: 0), with: .none)
    }
}

extension VCSettingMain: UITableViewDelegate, UITableViewDataSource {
    private func configureTable() {
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.register(VSettingCell.self, forCellReuseIdentifier: VSettingCell.id)
        
        table.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        table.separatorStyle = .singleLine
        table.separatorColor = ._gray_lg
        table.separatorInset = UIEdgeInsets(top: 4, left: 24, bottom: 4, right: 24)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : tableList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return Figure._profile_sm
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: VSettingCell.id, for: indexPath) as! VSettingCell
        
        if indexPath.section == 0 {
            cell.setCellByType(.profile)
    
        } else {
            if indexPath.row == 0 {
                let likedCount = User.getOrSaveUser.getLiked.count
                cell.setSettingCellWithData(tableList[0], sub: "\(likedCount)개의 상품")
            } else {
                cell.setSettingCellWithData(tableList[indexPath.row])
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {            
            let vc = VCSettingProfile()
            vc.configureViewAtUpdate()
            
            navigationController?.pushViewController(vc, animated: true)
            table.reloadSections(IndexSet(integer: 0), with: .none)
        } else  {
            if indexPath.row == tableList.count - 1 {
                table.reloadSections(IndexSet(integer: 1), with: .none)
                present(_showAlert(), animated: true)
            }
        }
    }
}
