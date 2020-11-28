//
//  VerticalStackView.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
  init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
    super.init(frame: .zero)
    
    arrangedSubviews.forEach { addArrangedSubview($0) }
    
    self.spacing = spacing
    self.axis = .vertical
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
