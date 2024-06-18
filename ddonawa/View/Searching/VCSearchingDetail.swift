//
//  VCSearchDetail.swift
//  ddonawa
//
//  Created by 강한결 on 6/15/24.
//

import UIKit
import WebKit
import SnapKit

class VCSearchingDetail: VCMain {
    private lazy var itemId: String = ""
    private lazy var itemName: String = ""
    private lazy var itemWebLink: String = ""
    
    private let web = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rightBarItem = UIBarButtonItem(image: User.getOrSaveUser.isInLiked(itemId) ? UIImage.likeSelected : UIImage.likeUnselected, style: .plain, target: self, action: #selector(toggleLikeButton))

        rightBarItem.tintColor = ._gray_lg
        
        configureNav(navTitle: itemName, left: genLeftGoBackBarButton(), right: rightBarItem)
    }
}

extension VCSearchingDetail {
    func setVCWithData(_ data: Product) {
        itemId = data.productId
        itemName = _replaceHTMLTag(data.title)
        itemWebLink = data.link
        
    }
    
    func configureWebView() {
        view.addSubview(web)
        web.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        web.load(URLRequest(url: URL(string: itemWebLink)!))
    }
}

extension VCSearchingDetail {
    @objc
    private func toggleLikeButton() {
        var user = User.getOrSaveUser
        
        if !user.isInLiked(itemId) {
            user.addLiked(ProductUserLiked(productId: itemId))
        } else {
            user.deleteLiked(itemId)
        }
        
        User.getOrSaveUser = user
        self.viewWillAppear(true)
    }
}
