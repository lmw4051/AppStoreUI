//
//  TodayMultipleAppsController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/29.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class TodayMultipleAppsController: BaseListController, UICollectionViewDelegateFlowLayout {
  // MARK: - Instance Properties
  let cellId = "CellId"
  
  var apps = [FeedResult]()
  
  fileprivate let spacing: CGFloat = 16
  
  enum Mode {
    case small, fullScreen
  }
  
  fileprivate let mode: Mode
  
  let closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
    button.tintColor = .darkGray
    button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Selector Methods
  @objc func handleDismiss() {
    dismiss(animated: true)
  }
  
  // MARK: - View Life Cycle
  init(mode: Mode) {
    self.mode = mode
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    
    if mode == .fullScreen {
      setupCloseButton()
    } else {
      collectionView.isScrollEnabled = false
    }
    
    collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellId)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }
  
  // MARK: - Helper Methods
  func setupCloseButton() {
    view.addSubview(closeButton)
    closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
  }
  
  // MARK: - UICollectioViewDataSource Methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if mode == .fullScreen {
      return apps.count
    }
    return min(4, apps.count)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppCell
    cell.app = self.apps[indexPath.item]
    return cell
  }
  
  // MARK: - UICollectioViewDelegate Methods
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let appId = self.apps[indexPath.item].id
    let appDetailController = AppDetailController(appId: appId)
//    navigationController?.isNavigationBarHidden = false
    navigationController?.pushViewController(appDetailController, animated: true)
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout Methods
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let height: CGFloat = 68
   
    if mode == .fullScreen {
      return .init(width: view.frame.width - 48, height: height)
    }
    return .init(width: view.frame.width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if mode == .fullScreen {
      return .init(top: 60, left: 24, bottom: 12, right: 24)
    }
    return .zero
  }
}
