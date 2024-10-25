//
//  +Views.swift
//  ddonawa
//
//  Created by 강한결 on 10/25/24.
//

import UIKit

extension UIView {
   func addSubviews(for views: UIView...) {
      views.forEach { self.addSubview($0) }
   }
}
