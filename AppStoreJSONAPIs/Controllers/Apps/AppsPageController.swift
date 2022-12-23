//
//  AppsController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {
  // MARK: - Instance Properties
  let cellId = "AppsCell"
  let headerId = "HeaderId"
  
  var groups = [AppGroup]()
  var socialApps = [SocialApp]()
  
  let activityIndicatorView: UIActivityIndicatorView = {
    let aiv = UIActivityIndicatorView(style: .whiteLarge)
    aiv.color = .black
    aiv.startAnimating()
    aiv.hidesWhenStopped = true
    return aiv
  }()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    
    view.addSubview(activityIndicatorView)
    activityIndicatorView.fillSuperview()
    
    fetchData()
  }
  
  fileprivate func fetchData() {
    var group1: AppGroup?
    var group2: AppGroup?
    
    let dispatchGroup = DispatchGroup()
    
    dispatchGroup.enter()
    Service.shared.fetchTopPaid { (appGroup, error) in
      print("Done with top paid")
      dispatchGroup.leave()
      group1 = appGroup
    }
    
    dispatchGroup.enter()
    Service.shared.fetchTopFree { (appGroup, error) in
      print("Done with top free")
      dispatchGroup.leave()
      group2 = appGroup
    }
    
    dispatchGroup.enter()
    Service.shared.fetchSocialApps { (apps, error) in
      dispatchGroup.leave()
      self.socialApps = apps ?? []
    }
    
    dispatchGroup.notify(queue: .main) {
      print("Completed your dispatch group task")
      
      self.activityIndicatorView.stopAnimating()
      
      if let group = group1 {
        self.groups.append(group)
      }
      if let group = group2 {
        self.groups.append(group)
      }
//      if let group = group3 {
//        self.groups.append(group)
//      }
      self.collectionView.reloadData()
    }
  }
  
  // MARK: - UICollectionViewDataSource Methods
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
    header.appHeaderHorizontalController.socialApps = self.socialApps
    header.appHeaderHorizontalController.collectionView.reloadData()
    return header
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
    cell.horizontalController.didSelectHandler = { [weak self] feedResult in
      
      let controller = AppDetailController(appId: feedResult.id)      
      controller.view.backgroundColor = .white
      controller.navigationItem.title = feedResult.name
      self?.navigationController?.pushViewController(controller, animated: true)
    }
    return cell
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout Methods
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
}
