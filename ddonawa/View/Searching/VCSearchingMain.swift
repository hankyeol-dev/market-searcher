//
//  VCSearchingMain.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import UIKit
import SnapKit

class VCSearchingMain: UIViewController {
    private lazy var recentSearchList: [String] = []
    
    let searchBar = UISearchBar()
    let recentSearchTable = UITableView()
    let recentSearchMenu = UIView()
    let recentTLabel = VLabel(Texts.Menu.RECENTSEARCHING.rawValue, tType: .impact)
    let recentDBtn = UIButton()
    let emptyImg = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if User.isSavedUser {
            configureNavigation()
                        
            let user = User.getOrSaveUser
            
            if user.getRecentSearch.count == 0 {
                recentSearchMenu.isHidden = true
                emptyRecentSearching()
            } else {
                recentSearchMenu.isHidden = false
                recentSearchList = user.getRecentSearch
                configureTable()
                recentSearchTable.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
    }
    
    
}

extension VCSearchingMain {
    private func configureNavigation() {
        let nickname = User.getOrSaveUser.getOrChangeNick
        configureNav(navTitle: "\(nickname) 님의 또나와", left: nil, right: nil)
    }

    private func emptyRecentSearching() {
        view.addSubview(emptyImg)
        
        emptyImg.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.top.equalTo(searchBar.snp.bottom).offset(80)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
        
        emptyImg.image = ._empty
        emptyImg.contentMode = .scaleAspectFit
    }
}

extension VCSearchingMain: UISearchBarDelegate {
    private func configureSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.delegate = self
        
        searchBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
        
        searchBar.placeholder = Texts.Placeholders.SEARCHING_PRODUCT.rawValue
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search()
    }
    
    private func search() {
        guard let text = searchBar.text else { return }
        
        if !text.isEmpty {
            // user update
            var user = User.getOrSaveUser
            
            if !recentSearchList.contains(text) {
                user.addRecentSearch(text)
            }
            User.getOrSaveUser = user
            
            // 이동처리
            let vc = VCSearchingList()
            vc.setVCWithData(text)
            searchBar.text = ""
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension VCSearchingMain: UITableViewDelegate, UITableViewDataSource {
    private func configureTable() {
        view.addSubview(recentSearchMenu)
        recentSearchMenu.addSubview(recentTLabel)
        recentSearchMenu.addSubview(recentDBtn)
        view.addSubview(recentSearchTable)
        
        recentSearchMenu.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        recentTLabel.snp.makeConstraints {
            $0.leading.verticalEdges.equalTo(recentSearchMenu.safeAreaLayoutGuide).inset(8)
        }
        
        recentDBtn.snp.makeConstraints {
            $0.trailing.verticalEdges.equalTo(recentSearchMenu.safeAreaLayoutGuide).inset(8)
        }
        
        recentSearchTable.snp.makeConstraints {
            $0.top.equalTo(recentSearchMenu.snp.bottom).offset(8)
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        recentDBtn.setTitle(Texts.Buttons.RECENTSEARCHING_DELETE_BTN.rawValue, for: .normal)
        recentDBtn.setTitleColor(._main, for: .normal)
        recentDBtn.titleLabel?.font = ._xs
        recentDBtn.addTarget(self, action: #selector(deleteAllSearch), for: .touchUpInside)
        
        recentSearchTable.delegate = self
        recentSearchTable.dataSource = self
        recentSearchTable.register(VRecentSearchCell.self, forCellReuseIdentifier: VRecentSearchCell.id)
        recentSearchTable.rowHeight = 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentSearchTable.dequeueReusableCell(withIdentifier: VRecentSearchCell.id, for: indexPath) as! VRecentSearchCell
        
        cell.setCellWithData(recentSearchList[recentSearchList.count - (indexPath.row + 1)], cellIndex: indexPath.row)
        cell.btn.tag = indexPath.row
        cell.btn.addTarget(self, action: #selector(deleteSearch), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.text = recentSearchList[recentSearchList.count - (indexPath.row + 1)]
        recentSearchTable.reloadSections(IndexSet(integer: 0), with: .none)
        search()
    }
    
    @objc
    private func deleteSearch(_ sender: UIButton) {
        var user = User.getOrSaveUser
        user.deleteRecentSearch(sender.tag)
        recentSearchList = user.getRecentSearch
        User.getOrSaveUser = user
        recentSearchTable.reloadSections(IndexSet(integer: 0), with: .none)
        self.viewWillAppear(true)
    }
    
    @objc
    private func deleteAllSearch(_ sender: UIButton) {
        recentSearchList = []
        var user = User.getOrSaveUser
        user.deleteAllRecentSearch()
        User.getOrSaveUser = user
        recentSearchTable.reloadSections(IndexSet(integer: 0), with: .none)
        
        viewWillAppear(true)
    }

}
