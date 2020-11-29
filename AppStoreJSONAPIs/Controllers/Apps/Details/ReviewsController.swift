//
//  ReviewsController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class ReviewsController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
  // MARK: - Instance Properties
  let cellId = "cellId"
  
  var reviews: Reviews? {
    didSet {
      collectionView.reloadData()
    }
  }
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
  }
  
  // MARK: - UICollectioViewDataSource Methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return reviews?.feed.entry.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ReviewCell
    let entry = self.reviews?.feed.entry[indexPath.item]
    cell.titleLabel.text = entry?.title.label
    cell.authorLabel.text = entry?.author.name.label
    cell.bodyLabel.text = entry?.content.label
    
    for (index, view) in cell.starsStackView.arrangedSubviews.enumerated() {
      if let ratingInt = Int(entry!.rating.label) {
        view.alpha = index >= ratingInt ? 0 : 1
      }
    }
    
    return cell
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout Methods
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 48, height: view.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
}
