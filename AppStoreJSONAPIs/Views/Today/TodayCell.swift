//
//  TodayCell.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/29.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
  // MARK: - Instance Properties
  let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
  
  // MARK: - View Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    layer.cornerRadius = 16
    
    addSubview(imageView)
    imageView.contentMode = .scaleAspectFill
    imageView.centerInSuperview(size: .init(width: 250, height: 250))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
