//
//  HorizontalSnappingController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {
  // MARK: - View Life Cycle
  init() {
    let layout = BetterSnappingLayout()
    layout.scrollDirection = .horizontal
    super.init(collectionViewLayout: layout)
    
    collectionView.decelerationRate = .fast
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
