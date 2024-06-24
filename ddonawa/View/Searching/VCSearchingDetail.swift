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
    private lazy var item: ProductUserLiked = ProductUserLiked(productId: "", image: "", title: "", lprice: "", link: "")
    
    private let web = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rightBarItem = UIBarButtonItem(image: User.getOrSaveUser.isInLiked(item.productId) ? UIImage.likeSelected : UIImage.likeUnselected, style: .plain, target: self, action: #selector(toggleLikeButton))

        rightBarItem.tintColor = ._gray_lg
        
        configureNav(navTitle: _replaceHTMLTag(item.title), left: _genLeftGoBackBarButton(), right: rightBarItem)
    }
}

extension VCSearchingDetail {
    func setVCWithData(_ data: Product) {
        item = ProductUserLiked(productId: data.productId, image: data.image, title: data.title, lprice: data.lprice, link: data.link)
    }
    
    func configureWebView() {
        view.addSubview(web)
        web.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        web.load(URLRequest(url: URL(string: item.link)!))
    }
}

extension VCSearchingDetail {
    @objc
    private func toggleLikeButton() {
        var user = User.getOrSaveUser
        
        if !user.isInLiked(item.productId) {
            user.addLiked(
                ProductUserLiked(productId: item.productId, image: item.image, title: item.title, lprice: item.lprice, link: item.link)
            )
        } else {
            user.deleteLiked(item.productId)
        }
        
        User.getOrSaveUser = user
        self.viewWillAppear(true)
    }
}
