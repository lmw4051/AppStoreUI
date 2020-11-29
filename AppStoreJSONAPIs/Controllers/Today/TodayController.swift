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
  var startingFrame: CGRect?
  var appFullScreenController: AppFullScreenController!
  
  var topConstraint: NSLayoutConstraint?
  var leadingConstraint: NSLayoutConstraint?
  var widthConstraint: NSLayoutConstraint?
  var heightConstraint: NSLayoutConstraint?
  
  var items = [TodayItem]()
  
  let activityIndicatorView: UIActivityIndicatorView = {
    let aiv = UIActivityIndicatorView(style: .whiteLarge)
    aiv.color = .darkGray
    aiv.startAnimating()
    aiv.hidesWhenStopped = true
    return aiv
  }()
  
  static let cellSize: CGFloat = 500
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(activityIndicatorView)
    activityIndicatorView.centerInSuperview()
    
    fetchData()
    
    navigationController?.isNavigationBarHidden = true
    collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489068389, alpha: 1)
    collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
    collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
  }
  
  fileprivate func fetchData() {
    let dispatchGroup = DispatchGroup()
    
    var topGrossingGroup: AppGroup?
    var gamesGroup: AppGroup?
    
    dispatchGroup.enter()
    Service.shared.fetchTopGrossing { (appGroup, error) in
      topGrossingGroup = appGroup
      dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    Service.shared.fetchGames { (appGroup, error) in
      gamesGroup = appGroup
      dispatchGroup.leave()
    }
    
    dispatchGroup.notify(queue: .main) {
      print("Finished fetching")
      self.activityIndicatorView.stopAnimating()
      
      self.items = [
        TodayItem.init(category: "Daily List", title: topGrossingGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topGrossingGroup?.feed.results ?? []),
        
        TodayItem.init(category: "Daily List", title: gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: gamesGroup?.feed.results ?? []),
        
        TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: []),
        TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1), cellType: .single, apps: []),
      ]
      
      self.collectionView.reloadData()
    }
  }
  
  // MARK: - UICollectioViewDataSource Methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cellId = items[indexPath.item].cellType.rawValue
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
    cell.todayItem = items[indexPath.item]
    return cell
  }
  
  // MARK: - UICollectioViewDelegate Methods
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if items[indexPath.item].cellType == .multiple {
      let fullController = TodayMultipleAppsController(mode: .fullScreen)
      fullController.results = self.items[indexPath.item].apps      
      present(fullController, animated: true)
      return
    }
    
    let appFullScreenController = AppFullScreenController()
    appFullScreenController.todayItem = items[indexPath.item]
    appFullScreenController.dismissHandler = {
      self.handleRemoveFullScreenView()
    }
    
    let fullScreenView = appFullScreenController.view!    
    view.addSubview(fullScreenView)
    
    // This will let tableView of AppFullScreenController render itself
    // in order to show Header
    addChild(appFullScreenController)
    
    self.appFullScreenController = appFullScreenController
    
    self.collectionView.isUserInteractionEnabled = false
    
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    
    // Absolute Coordinates of Cell
    guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    self.startingFrame = startingFrame
    
    // AutoLayout Constraint Animations
    fullScreenView.translatesAutoresizingMaskIntoConstraints = false
    topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
    leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
    widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
    heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
    
    [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach { $0?.isActive = true }
    self.view.layoutIfNeeded()
    
    fullScreenView.layer.cornerRadius = 16
    
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
      
      self.topConstraint?.constant = 0
      self.leadingConstraint?.constant = 0
      self.widthConstraint?.constant = self.view.frame.width
      self.heightConstraint?.constant = self.view.frame.height
      
      // Start Animation
      self.view.layoutIfNeeded()
      
      // For Xcode 11
      self.tabBarController?.tabBar.frame.origin.y += 100
      // Before Xcode 11
      //      self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
      
      guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else { return }
      cell.todayCell.topConstraint.constant = 48
      cell.layoutIfNeeded()
    }, completion: nil)
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout Methods
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 64, height: TodayController.cellSize)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 32
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 32, left: 0, bottom: 32, right: 0)
  }
  
  // MARK: - Selector Methods
  @objc func handleRemoveFullScreenView() {
    // Access startingFrame
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
      
      self.appFullScreenController.tableView.contentOffset = .zero
      
      guard let startingFrame = self.startingFrame else { return }
      
      self.topConstraint?.constant = startingFrame.origin.y
      self.leadingConstraint?.constant = startingFrame.origin.x
      self.widthConstraint?.constant = startingFrame.width
      self.heightConstraint?.constant = startingFrame.height
      
      self.view.layoutIfNeeded()
      
      // For Xcode 11
      self.tabBarController?.tabBar.frame.origin.y -= 100
      
      // Before Xcode 11
      //      self.tabBarController?.tabBar.transform = .identity
      
      guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else { return }
      cell.todayCell.topConstraint.constant = 24
      cell.layoutIfNeeded()
    }, completion: { _ in
      self.appFullScreenController.view.removeFromSuperview()
      self.appFullScreenController.removeFromParent()
      self.collectionView.isUserInteractionEnabled = true
    })
  }
}
