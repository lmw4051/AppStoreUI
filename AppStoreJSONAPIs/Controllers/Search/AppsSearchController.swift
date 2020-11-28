//
//  AppsSearchController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/27.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppsSearchController: BaseListController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
  // MARK: - Properties
  fileprivate let cellId = "SearchCell"
  fileprivate var appResults = [Result]()
  
  fileprivate let searchController = UISearchController(searchResultsController: nil)
  var timer: Timer?
  
  fileprivate let enterSearchTermLabel: UILabel = {
    let label = UILabel()
    label.text = "Please enter search term above..."
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
  }()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
    
    collectionView.addSubview(enterSearchTermLabel)
    enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
    
    setupSearchBar()
//    fetchITunesApps()
  }
  
  // MARK: - Search
  fileprivate func setupSearchBar() {
    navigationItem.searchController = self.searchController
    searchController.searchBar.delegate = self
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print(searchText)
            
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
      Service.shared.fetchApps(searchTerm: searchText) { (result, error) in
        self.appResults = result
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    })
  }
  
  fileprivate func fetchITunesApps() {
    Service.shared.fetchApps(searchTerm: "instagram") { (results, error) in
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
  
  // MARK: - UICollectioView DataSource Methods
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    enterSearchTermLabel.isHidden = appResults.count != 0
    return appResults.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell    
    cell.appResult = appResults[indexPath.item]
    return cell
  }
}
