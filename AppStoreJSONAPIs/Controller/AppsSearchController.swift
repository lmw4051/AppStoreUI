//
//  AppsSearchController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/27.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppsSearchController: UICollectionViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .red
  }
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
