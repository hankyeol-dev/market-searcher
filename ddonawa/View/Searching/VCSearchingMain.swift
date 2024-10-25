//
//  VCSearchingMain.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import UIKit
import SnapKit
import RealmSwift

class VCSearchingMain: VCMain {
    private var userId: ObjectId!
    private let searchRepository = Repository<RealmUserSearch>()
    private var recentSearchList: Results<RealmUserSearch>!
    
    let searchBar = UISearchBar()
    let recentSearchTable = UITableView()
    let recentSearchMenu = UIView()
    let recentTLabel = VLabel(Texts.Menu.RECENTSEARCHING.rawValue, tType: .impact)
    let recentDBtn = UIButton()
    let emptyImg = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        self.recentSearchList = searchRepository.getRecords()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let username = UserService.manager.getOrSetUserNick
        if username != "" {
            configureNav(navTitle: "\(username)님의 또나와", left: nil, right: nil)
            
            if recentSearchList?.count == 0 {
                recentSearchMenu.isHidden = true
                emptyRecentSearching()
            } else {
                recentSearchMenu.isHidden = false
                configureTable()
                recentSearchTable.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
}

extension VCSearchingMain {
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
            let keyword = searchRepository.getRecords().where { record in
                record.keyword == text
            }
            
            if keyword.count == 0 {
                searchRepository.addRecord(RealmUserSearch(keyword: text))
            }
            
            // 이동처리
            let vc = SearchHomeViewController()
            vc.setSearchText(text)
            searchBar.text = ""
            view.endEditing(true)
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
        
        cell.setCellWithData(recentSearchList[recentSearchList.count - (indexPath.row + 1)].keyword, cellIndex: indexPath.row)
        cell.btn.tag = indexPath.row
        cell.btn.addTarget(self, action: #selector(deleteSearch), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.text = recentSearchList[recentSearchList.count - (indexPath.row + 1)].keyword
        recentSearchTable.reloadSections(IndexSet(integer: 0), with: .none)
        search()
    }
    
    @objc
    private func deleteSearch(_ sender: UIButton) {
        searchRepository.deleteRecord(recentSearchList[sender.tag])
        if recentSearchList.count == 0 {
            recentSearchMenu.isHidden = true
            emptyRecentSearching()
        } else {
            recentSearchMenu.isHidden = false
            configureTable()
        }
        recentSearchTable.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    @objc
    private func deleteAllSearch(_ sender: UIButton) {
        searchRepository.deleteAllRecords()
        recentSearchMenu.isHidden = true
        emptyRecentSearching()
        recentSearchTable.reloadSections(IndexSet(integer: 0), with: .none)
    }

}
