//
//  ScreenshotCell.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
  // MARK: - Instance Properties
  let imageView = UIImageView(cornerRadius: 12)
  
  // MARK: - View Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)    
    addSubview(imageView)
    imageView.fillSuperview()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}
