//
//  AppsHorizontalController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppsHorizontalController: BaseListController, UICollectionViewDelegateFlowLayout {
  // MARK: - Properties
  let cellId = "HorizontalCell"
  let topBottomPadding: CGFloat = 12
  let lineSpacing: CGFloat = 10
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .blue
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    
    if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
      layout.scrollDirection = .horizontal
    }
  }
  
  // MARK: - UICollectionViewDataSource Methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    cell.backgroundColor = .red
    return cell
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout Methods
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let height = (view.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 3
      return .init(width: view.frame.width - 48, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return lineSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: topBottomPadding, left: 16, bottom: topBottomPadding, right: 16)
  }
}
