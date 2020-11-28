//
//  ReviewRowCell.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
  
  let reviewsController = ReviewsController()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .yellow
    
    addSubview(reviewsController.view)
    reviewsController.view.fillSuperview()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
