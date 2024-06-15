//
//  VCSearchingList.swift
//  ddonawa
//
//  Created by 강한결 on 6/15/24.
//

import UIKit

class VCSearchingList: UIViewController {
    lazy var searchingKeyword = ""
    private lazy var searchingList:[Product] = []
    private lazy var searchingStart: Int = 0
    private lazy var searchingTotal: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNav(navTitle: searchingKeyword, left: genLeftGoBackBarButton(), right: nil)
    }
    
    
}

extension VCSearchingList {
    func setVCWithData(_ keyword: String) {
        self.searchingKeyword = keyword
        
        // api
    }
}
