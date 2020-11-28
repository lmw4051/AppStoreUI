//
//  AppDetailController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
  // MARK: - Instance Properties
  var appId: String! {
    didSet {
      print("Here is my appId:", appId)
      let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
      Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, err) in
        let app = result?.results.first
        self.app = app
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    }
  }
  
  var app: Result?
  let detailCellId = "DetailCellId"
  let previewCellId = "PreviewCellId"
  let reviewCellId = "ReviewCellId"
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
    collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
    collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellId)
    
    
    navigationItem.largeTitleDisplayMode = .never
  }
  
  // MARK: - UICollectionViewDataSource Methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if indexPath.item == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
      cell.app = app
      return cell
    } else if indexPath.item == 1 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
      cell.horizontalController.app = self.app
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewRowCell
      return cell
    }
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout Methods
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    var height: CGFloat = 280
    
    if indexPath.item == 0 {
      let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
      dummyCell.app = app
      dummyCell.layoutIfNeeded()
      
      let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
      
      height = estimatedSize.height
    } else if indexPath.item == 1 {
      height = 500
    } else {
      height = 280
    }
    
    return .init(width: view.frame.width, height: height)
  }
}
