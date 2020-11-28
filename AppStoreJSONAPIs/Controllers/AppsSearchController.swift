//
//  AppsSearchController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/27.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  fileprivate let cellId = "SearchCell"
  fileprivate var appResults = [Result]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
    
    fetchITunesApps()
  }
  
  fileprivate func fetchITunesApps() {
    Service.shared.fetchApps { (results, error) in
      if let error = error {
        print("Failed to fetch apps:", error)
        return
      }
      
      self.appResults = results
      
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return appResults.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell    
    cell.appResult = appResults[indexPath.item]
    return cell
  }
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
