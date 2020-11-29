//
//  TodayController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/29.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout {
  // MARK: - Instance Properties
  fileprivate let cellId = "CellId"
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = true
    collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489068389, alpha: 1)
    collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
  }
  
  // MARK: - UICollectioViewDataSource Methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
    return cell
  }
  
  // MARK: - UICollectioViewDelegate Methods
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("animte full screen")
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout Methods
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 64, height: 450)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 32
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 32, left: 0, bottom: 32, right: 0)
  }
}
