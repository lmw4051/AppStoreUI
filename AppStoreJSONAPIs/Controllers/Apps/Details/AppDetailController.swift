//
//  AppDetailController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
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
  
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
    navigationItem.largeTitleDisplayMode = .never
  }
  
  // MARK: - UICollectionViewDataSource Methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
    cell.app = app
    return cell
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout Methods
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
    dummyCell.app = app
    dummyCell.layoutIfNeeded()
    
    let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
    
    return .init(width: view.frame.width, height: estimatedSize.height)
  }
}