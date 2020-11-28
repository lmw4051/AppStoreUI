//
//  AppsController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {
  // MARK: - Properties
  let cellId = "AppsCell"
  let headerId = "HeaderId"
  
  var groups = [AppGroup]()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    
    fetchData()
  }
  
  fileprivate func fetchData() {
    var group1: AppGroup?
    var group2: AppGroup?
    var group3: AppGroup?
    
    let dispatchGroup = DispatchGroup()
    
    dispatchGroup.enter()
    Service.shared.fetchGames { (appGroup, error) in
      print("Done with games")
      dispatchGroup.leave()
      group1 = appGroup
    }
    
    dispatchGroup.enter()
    Service.shared.fetchTopGrossing { (appGroup, error) in
      print("Done with top grossing")
      dispatchGroup.leave()
      group2 = appGroup
    }
    
    dispatchGroup.enter()
    Service.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json") { (appGroup, error) in
      dispatchGroup.leave()
      print("Done with free games")
      group3 = appGroup
    }
    
    dispatchGroup.notify(queue: .main) {
      print("Completed your dispatch group task")
      
      if let group = group1 {
        self.groups.append(group)
      }
      if let group = group2 {
        self.groups.append(group)
      }
      if let group = group3 {
        self.groups.append(group)
      }
      self.collectionView.reloadData()
    }
  }
  
  // MARK: - UICollectionViewDataSource Methods
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
    return header
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 0)
  }
    
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return groups.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
    
    let appGroup = groups[indexPath.item]
    
    cell.titleLabel.text = appGroup.feed.title
    cell.horizontalController.appGroup = appGroup
    cell.horizontalController.collectionView.reloadData()
    return cell
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout Methods
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 0, right: 0)
  }
}
