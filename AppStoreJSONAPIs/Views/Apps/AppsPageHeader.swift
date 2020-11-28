//
//  AppsPageHeader.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
  
  let appHeaderHorizontalController = AppsHeaderHorizontalController()
  
  // MARK: - View Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)        
    addSubview(appHeaderHorizontalController.view)
    appHeaderHorizontalController.view.fillSuperview()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
