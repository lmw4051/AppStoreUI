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
  var appFullScreenController: AppFullScreenController!
  
  var topConstraint: NSLayoutConstraint?
  var leadingConstraint: NSLayoutConstraint?
  var widthConstraint: NSLayoutConstraint?
  var heightConstraint: NSLayoutConstraint?
  
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
    
    appFullScreenController.dismissHandler = {
      self.handleRemoveAFSCView()
    }
    
    let aFSCView = appFullScreenController.view!
    aFSCView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveAFSCView)))
    view.addSubview(aFSCView)
        
    // This will let tableView of AppFullScreenController render itself
    // in order to show Header
    addChild(appFullScreenController)
    
    self.appFullScreenController = appFullScreenController
    
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    
    // Absolute Coordinates of Cell
    guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    self.startingFrame = startingFrame
    
    // AutoLayout Constraint Animations
    aFSCView.translatesAutoresizingMaskIntoConstraints = false
    topConstraint = aFSCView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
    leadingConstraint = aFSCView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
    widthConstraint = aFSCView.widthAnchor.constraint(equalToConstant: startingFrame.width)
    heightConstraint = aFSCView.heightAnchor.constraint(equalToConstant: startingFrame.height)
    
    [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach { $0?.isActive = true }
    self.view.layoutIfNeeded()
    
    aFSCView.layer.cornerRadius = 16
        
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
  @objc func handleRemoveAFSCView() {
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
    }, completion: { _ in
      self.appFullScreenController.view.removeFromSuperview()
      self.appFullScreenController.removeFromParent()
    })
  }
}
