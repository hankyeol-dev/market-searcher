//
//  VCSearchingList.swift
//  ddonawa
//
//  Created by 강한결 on 6/15/24.
//

import UIKit
import SnapKit
import Alamofire
import Toast

class VCSearchingList: VCMain {
    private lazy var query = ""
    private lazy var filterButtonSortTypes = [SortType.sim, SortType.date, SortType.asc, SortType.dsc]
    private lazy var searchingList:[Product] = []
    private lazy var searchingStart: Int = 1
    private lazy var searchingTotal: Int = 0
    private lazy var sortType: SortType = .sim
    
    private let searchCountLabel = VLabel(" ", tColor: ._main, tType: .impact)
    private let filterButtonStack = UIStackView()
    private let searchingCollection = {
        let layout = UICollectionViewFlowLayout()
        
        let width = (UIScreen.main.bounds.width - 48) / 2
        let height = width * 1.75
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let filterButtons: [VFilterButton] = [
        VFilterButton(Texts.Buttons.FILTER_SIM.rawValue),
        VFilterButton(Texts.Buttons.FILTER_DATE.rawValue),
        VFilterButton(Texts.Buttons.FILTER_PRICE_ASC.rawValue),
        VFilterButton(Texts.Buttons.FILTER_PRICE_DSC.rawValue)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubView()
        configureLayout()
        configureStackAndButton()
        configureCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNav(navTitle: query, left: _genLeftGoBackBarButton(), right: nil)
        searchingCollection.reloadData()
    }
    
}

extension VCSearchingList {
    private func configureSubView() {
        view.addSubview(searchCountLabel)
        view.addSubview(filterButtonStack)
        filterButtons.enumerated().forEach { (idx, v) in
            v.tag = idx
            v.addTarget(self, action: #selector(sortButtonTouch), for: .touchUpInside)
            filterButtonStack.addArrangedSubview(v)
        }
    }
    
    private func configureLayout() {
        searchCountLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(4)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        filterButtonStack.snp.makeConstraints {
            $0.top.equalTo(searchCountLabel.snp.bottom).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(120)
            $0.height.equalTo(24)
        }
    }
    
    private func configureStackAndButton() {
        filterButtonStack.axis = .horizontal
        filterButtonStack.spacing = 8
        filterButtonStack.distribution = .fillProportionally
        filterButtonStack.alignment = .center
        filterButtons[0].isSelected()
    }
}

extension VCSearchingList {
    func setVCWithData(_ keyword: String) {
        query = keyword
        
        fetchData(query: query, start: searchingStart, sort: sortType)
    }
}

extension VCSearchingList: UICollectionViewDelegate, UICollectionViewDataSource {
    private func configureCollection() {
        view.addSubview(searchingCollection)
        
        searchingCollection.snp.makeConstraints {
            $0.top.equalTo(filterButtonStack.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchingCollection.delegate = self
        searchingCollection.dataSource = self
        searchingCollection.register(VSeachingItem.self, forCellWithReuseIdentifier: VSeachingItem.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = searchingCollection.dequeueReusableCell(withReuseIdentifier: VSeachingItem.id, for: indexPath) as! VSeachingItem
        
        item.setItemWithData(searchingList[indexPath.row])
        
        return item
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        let collectionViewContentSizeY = searchingCollection.contentSize.height
        
        let paginationY = collectionViewContentSizeY * 0.8
        
        if contentOffsetY > collectionViewContentSizeY - paginationY {
            fetchData(query: self.query, start: self.searchingStart + 30, sort: self.sortType)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = VCSearchingDetail()
        let data = searchingList[indexPath.row]
        
        vc.setVCWithData(data)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension VCSearchingList {
    private func fetchData(query: String, start: Int, sort: SortType) {
        DispatchQueue.global().async {
            APIService.manager.fetch(query: query, start: start, sort: sort) { (data: ProductResult?, error: APIService.Errors?) in
                if error != nil {
                    self.view.makeToast("뭔가 에러가 있어요 :(", position: .bottom)
                }
                
                guard let data else { return }
                
                self.searchingTotal = data.total
                if self.searchingTotal > self.searchingStart {
                    for item in data.items {
                        self.searchingList.append(item)
                    }
                    self.searchingStart += data.start
                    DispatchQueue.main.async {
                        self.searchCountLabel.changeLabelText("\(_formatString(String(self.searchingTotal)))" + Texts.Menu.SEARCHING_TOTAL_COUNTS.rawValue)
                        self.searchingCollection.reloadSections(IndexSet(integer: 0))
                    }
                }
            }
        }
    }
    
    @objc
    func sortButtonTouch(_ sender: UIButton) {
        if self.sortType != filterButtonSortTypes[sender.tag] {
            filterButtons.enumerated().forEach { (idx, v) in
                if idx == sender.tag {
                    v.isSelected()
                } else {
                    v.disSelected()
                }
            }
            
            self.searchingStart = 1
            self.searchingTotal = 0
            self.searchingList = []
            self.sortType = filterButtonSortTypes[sender.tag]
            
            fetchData(query: query, start: searchingStart, sort: sortType)
        }
    }
}
