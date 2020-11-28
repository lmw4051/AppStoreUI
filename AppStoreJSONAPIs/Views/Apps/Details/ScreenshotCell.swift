//
//  ScreenshotCell.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
  
  let imageView = UIImageView(cornerRadius: 12)
  
  override init(frame: CGRect) {
    super.init(frame: frame)    
    addSubview(imageView)
    imageView.fillSuperview()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}
