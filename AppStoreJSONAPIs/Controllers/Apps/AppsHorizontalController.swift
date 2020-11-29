//
//  AppsHorizontalController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
  // MARK: - Instance Properties
  let cellId = "HorizontalCell"
  let topBottomPadding: CGFloat = 12
  let lineSpacing: CGFloat = 10
  
  var appGroup: AppGroup?
  
  var didSelectHandler: ((FeedResult) -> ())?
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
  }
  
  // MARK: - UICollectionViewDataSource Methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return appGroup?.feed.results.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppRowCell
    let app = appGroup?.feed.results[indexPath.item]
    cell.nameLabel.text = app?.name
    cell.companyLabel.text = app?.artistName
    cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
    return cell
  }
  
  // MARK: - UICollectionViewDelegate Methods
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let app = appGroup?.feed.results[indexPath.item] {
      didSelectHandler?(app)
    }
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout Methods
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let height = (view.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 3
      return .init(width: view.frame.width - 48, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return lineSpacing
  }
}
