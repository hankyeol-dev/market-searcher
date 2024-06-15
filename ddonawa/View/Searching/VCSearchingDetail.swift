//
//  VCSearchDetail.swift
//  ddonawa
//
//  Created by 강한결 on 6/15/24.
//

import UIKit
import WebKit
import SnapKit

class VCSearchingDetail: UIViewController {
    private lazy var itemName: String = ""
    private lazy var webLink: String = ""
    
    private let web = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNav(navTitle: itemName, left: genLeftGoBackBarButton(), right: nil)
    }
}

extension VCSearchingDetail {
    func setVCWithData(_ title: String, _ link: String) {
        itemName = title
        webLink = link
    }
    
    func configureWebView() {
        
        view.addSubview(web)
        web.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        web.load(URLRequest(url: URL(string: webLink)!))
    }
}
