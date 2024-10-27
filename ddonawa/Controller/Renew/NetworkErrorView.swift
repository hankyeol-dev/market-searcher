//
//  NetworkErrorView.swift
//  ddonawa
//
//  Created by 강한결 on 10/27/24.
//

import UIKit

import SnapKit

final class NetworkErrorView: UIView {
   private let errorIcons: UIImageView = {
      let view = UIImageView()
      view.image = .networkError
      view.contentMode = .scaleAspectFit
      return view
   }()
   private let errorMessage: UILabel = {
      let view = UILabel()
      view.text = "앗! 네트워크 연결을 확인해주세요."
      view.textColor = ._tint_error
      view.textAlignment = .center
      return view
   }()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      backgroundColor = .white
      addSubviews(for: errorIcons, errorMessage)
      errorIcons.snp.makeConstraints { make in
         make.center.equalToSuperview()
         make.size.equalTo(56.0)
      }
      errorMessage.snp.makeConstraints { make in
         make.top.equalTo(errorIcons.snp.bottom).offset(15.0)
         make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15.0)
         make.height.equalTo(40.0)
      }
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
