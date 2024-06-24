//
//  VCLikedProductList.swift
//  ddonawa
//
//  Created by 강한결 on 6/24/24.
//

import UIKit
import SnapKit

class VCLikedProductList: VCMain {
    private let table = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rightButton = UIBarButtonItem(title: Texts.Buttons.NAVIGATION_DELETE_ALL.rawValue, style: .plain, target: self, action: #selector(deleteAllProductAtLiked))
        rightButton.tintColor = ._gray_lg
        
        configureNav(navTitle: "\(User.getOrSaveUser.getLiked.count)" + Texts.Navigations.LIKED_PRODUCT_LIST.rawValue, left: _genLeftGoBackBarButton(), right: rightButton)
        
        table.reloadSections(IndexSet(integer: 0), with: .none)
    }
}

extension VCLikedProductList: UITableViewDelegate, UITableViewDataSource {
    private func configureView() {
        view.addSubview(table)
        
        table.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        table.delegate = self
        table.dataSource = self
        table.register(VLikedCell.self, forCellReuseIdentifier: VLikedCell.id)
        table.rowHeight = 68
        table.separatorStyle = .singleLine
        table.separatorColor = ._gray_lg
        table.separatorInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.getOrSaveUser.getLiked.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: VLikedCell.id, for: indexPath) as! VLikedCell
        
        cell.setCellWithData(User.getOrSaveUser.getLiked[indexPath.row])
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(deleteProductAtLiked), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VCSearchingDetail()
        let data = User.getOrSaveUser.getLiked[indexPath.row]
        
        vc.setVCWithData(Product(productId: data.productId, title: data.title, mallName: "", productType: "", image: data.image, link: data.link, lprice: data.lprice))
        
        navigationController?.pushViewController(vc, animated: true)
        
        table.reloadSections(IndexSet(integer: 0), with: .none)
    }

}

extension VCLikedProductList {
    @objc
    private func deleteProductAtLiked(_ sender: UIButton) {
        
        var user = User.getOrSaveUser
        
        user.deleteLiked(user.getLiked[sender.tag].productId)
        
        User.getOrSaveUser = user
        
        table.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    @objc
    private func deleteAllProductAtLiked() {
        _showAlert(title: Texts.Alert.TITLE_DELETE_ALL.rawValue, message: Texts.Alert.MESSAGE_TITLE_DELETE_ALL.rawValue, actions: [
            UIAlertAction(title: Texts.Alert.CONFIRM.rawValue, style: .default, handler: { action in
                var user = User.getOrSaveUser
                user.deleteAllLiked()
                User.getOrSaveUser = user
                self.table.reloadSections(IndexSet(integer: 0), with: .none)
                self.navigationController?.popViewController(animated: true)
            }) ,
            UIAlertAction(title: Texts.Alert.CANCEL.rawValue, style: .cancel)
        ], animated: true)
    }
}
