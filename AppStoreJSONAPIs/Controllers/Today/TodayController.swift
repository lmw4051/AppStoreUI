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
  
  var anchoredConstraints: AnchoredConstraints?
  
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
  
  // MARK: - Service Methods
  fileprivate func fetchData() {
    let dispatchGroup = DispatchGroup()
    
    var topFreeGroup: AppGroup?
    var topPaidGroup: AppGroup?
    
    dispatchGroup.enter()
    Service.shared.fetchTopFree { (appGroup, error) in
      topFreeGroup = appGroup
      dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    Service.shared.fetchTopPaid { (appGroup, error) in
      topPaidGroup = appGroup
      dispatchGroup.leave()
    }
    
    dispatchGroup.notify(queue: .main) {
      print("Finished fetching")
      self.activityIndicatorView.stopAnimating()
      
      self.items = [
        TodayItem.init(category: "Daily List", title: topFreeGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topFreeGroup?.feed.results ?? []),
        
        TodayItem.init(category: "Daily List", title: topPaidGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topPaidGroup?.feed.results ?? []),
        
        TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: []),
        TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1), cellType: .single, apps: []),
      ]
      
      self.collectionView.reloadData()
    }
  }
  
  // MARK: - Helper Methods
  fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
    let fullController = TodayMultipleAppsController(mode: .fullScreen)
    fullController.apps = self.items[indexPath.item].apps
//    present(UINavigationController(rootViewController: fullController), animated: true)
    present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
    return
  }
  
  fileprivate func setupSingleAppFullscreenController(_ indexPath: IndexPath) {
    let appFullScreenController = AppFullScreenController()
    appFullScreenController.todayItem = items[indexPath.item]
    appFullScreenController.dismissHandler = {
      self.handleRemoveFullScreenView()
    }
    appFullScreenController.view.layer.cornerRadius = 16
    self.appFullScreenController = appFullScreenController
  }
  
  fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    
    // Absolute Coordinates of Cell
    guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    self.startingFrame = startingFrame
  }
  
  fileprivate func setupAppFullscreenStartingPosition(_ indexPath: IndexPath) {
    let fullScreenView = appFullScreenController.view!
    view.addSubview(fullScreenView)
    
    // This will let tableView of AppFullScreenController render itself
    // in order to show Header
    addChild(appFullScreenController)
    
    self.collectionView.isUserInteractionEnabled = false
    
    setupStartingCellFrame(indexPath)
    
    guard let startingFrame = self.startingFrame else { return }
    
    // AutoLayout Constraint Animations
    self.anchoredConstraints = fullScreenView.anchor(
      top: view.topAnchor,
      leading: view.leadingAnchor,
      bottom: nil,
      trailing: nil,
      padding: .init(
        top: startingFrame.origin.y,
        left: startingFrame.origin.x,
        bottom: 0,
        right: 0
      ),
      size: .init(
        width: startingFrame.width,
        height: startingFrame.height
      )
    )
    self.view.layoutIfNeeded()
  }
  
  fileprivate func beginAnimationAppFullscreen() {
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
      
      self.anchoredConstraints?.top?.constant = 0
      self.anchoredConstraints?.leading?.constant = 0
      self.anchoredConstraints?.width?.constant = self.view.frame.width
      self.anchoredConstraints?.height?.constant = self.view.frame.height
      
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
  
  func showSingleAppFullscreen(_ indexPath: IndexPath) {
    // Step 1
    setupSingleAppFullscreenController(indexPath)
    
    // Step 2 - setup full screen in its starting position
    setupAppFullscreenStartingPosition(indexPath)
    
    // Step 3 - begin the fullscreen animation
    beginAnimationAppFullscreen()
  }
  
  // MARK: - UICollectioViewDataSource Methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cellId = items[indexPath.item].cellType.rawValue
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
    cell.todayItem = items[indexPath.item]
    
    (cell as? TodayMultipleAppCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
    return cell
  }
  
  // MARK: - UICollectioViewDelegate Methods
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch items[indexPath.item].cellType {
    case .multiple:
      showDailyListFullScreen(indexPath)
    default:
      showSingleAppFullscreen(indexPath)
    }
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
  @objc fileprivate func handleMultipleAppsTap(gesture: UITapGestureRecognizer) {
    let collectionView = gesture.view
    
    var superView = collectionView?.superview
    
    // Figure out which cell where clicking into
    while superView != nil {
      if let cell = superView as? TodayMultipleAppCell {
        guard let indexPath = self.collectionView.indexPath(for: cell) else {
          return
        }
        
        let apps = self.items[indexPath.item].apps
        let fullController = TodayMultipleAppsController(mode: .fullScreen)
        fullController.apps = apps
        present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
        return
      }
      
      superView = superView?.superview
    }
  }
  
  @objc func handleRemoveFullScreenView() {
    // Access startingFrame
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
      
      self.appFullScreenController.tableView.contentOffset = .zero
      
      guard let startingFrame = self.startingFrame else { return }
      self.anchoredConstraints?.top?.constant = startingFrame.origin.y
      self.anchoredConstraints?.leading?.constant = startingFrame.origin.x
      self.anchoredConstraints?.width?.constant = startingFrame.width
      self.anchoredConstraints?.height?.constant = startingFrame.height
      
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
