//
//  TodayMultipleAppsController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/29.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class TodayMultipleAppsController: BaseListController, UICollectionViewDelegateFlowLayout {
  // MARK: - Instance Properties
  let cellId = "CellId"
  
  var results = [FeedResult]()
  
  fileprivate let spacing: CGFloat = 16
  
  enum Mode {
    case small, fullScreen
  }
  
  fileprivate let mode: Mode
  
  // MARK: - View Life Cycle
  init(mode: Mode) {
    self.mode = mode
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    
    if mode == .fullScreen {
      
    } else {
      collectionView.isScrollEnabled = false
    }
        
    collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellId)
  }
  
  // MARK: - UICollectioViewDataSource Methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if mode == .fullScreen {
      return results.count
    }
    return min(4, results.count)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppCell
    cell.app = self.results[indexPath.item]
    return cell
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout Methods
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let height: CGFloat = 68
   
    if mode == .fullScreen {
      return .init(width: view.frame.width - 48, height: height)
    }
    return .init(width: view.frame.width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if mode == .fullScreen {
      return .init(top: 12, left: 24, bottom: 12, right: 24)
    }
    return .zero
  }
}
