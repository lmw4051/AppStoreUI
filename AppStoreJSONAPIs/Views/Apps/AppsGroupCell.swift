//
//  AppsGroupCell.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
  // MARK: - View Properties
  let titleLabel = UILabel(text: "App Section", font: .boldSystemFont(ofSize: 30))
  
  let horizontalController = AppsHorizontalController()
  
  // MARK: - View Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(titleLabel)
    titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
    
    addSubview(horizontalController.view)    
    horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
