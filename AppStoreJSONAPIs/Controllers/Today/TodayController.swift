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
  var startingFrame: CGRect?
  var appFullScreenController: UIViewController!
  
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
    
    let appFullScreenController = AppFullScreenController()
    let redView = appFullScreenController.view!
    redView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
    view.addSubview(redView)
        
    // This will let tableView of AppFullScreenController render itself
    // in order to show Header
    addChild(appFullScreenController)
    
    self.appFullScreenController = appFullScreenController
    
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    
    // Absolute Coordinates of Cell
    guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    self.startingFrame = startingFrame
    redView.frame = startingFrame
    redView.layer.cornerRadius = 16
    
    // We're using frames for animation, but
    // frames aren't reliable enough for animations
    
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
      redView.frame = self.view.frame
      
      // For Xcode 11
      self.tabBarController?.tabBar.frame.origin.y += 100
      // Before Xcode 11
//      self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
    }, completion: nil)
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
  
  // MARK: - Selector Methods
  @objc func handleRemoveRedView(gesture: UITapGestureRecognizer) {
    // Access startingFrame
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
      gesture.view?.frame = self.startingFrame ?? .zero
      
      // For Xcode 11
      self.tabBarController?.tabBar.frame.origin.y -= 100
      
      // Before Xcode 11
//      self.tabBarController?.tabBar.transform = .identity
    }, completion: { _ in
      gesture.view?.removeFromSuperview()
      self.appFullScreenController.removeFromParent()
    })
  }
}
