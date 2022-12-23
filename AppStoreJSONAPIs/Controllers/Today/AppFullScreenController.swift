//
//  AppFullScreenController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/29.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppFullScreenController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  // MARK: - Instance Properties
  let tableView = UITableView(frame: .zero, style: .plain)
  var dismissHandler: (() ->())?
  var todayItem: TodayItem?
  
  let closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
    return button
  }()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(tableView)
    tableView.fillSuperview()
    tableView.dataSource = self
    tableView.delegate = self
    
    setupCloseButton()
    
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.contentInsetAdjustmentBehavior = .never
    let height = UIApplication.shared.statusBarFrame.height
    tableView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
  }
  
  // MARK: - UITableViewDataSource Methods
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.item == 0 {
      let headerCell = AppFullScreenHeaderCell()
      headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
      headerCell.todayCell.todayItem = todayItem
      headerCell.todayCell.layer.cornerRadius = 0
      headerCell.clipsToBounds = true
      headerCell.todayCell.backgroundView = nil
      return headerCell
    }
    let cell = AppFullScreenDescriptionCell()
    return cell
  }
  
  // MARK: - UITableViewDelegate Methods
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return TodayController.cellSize
    }
    return UITableView.automaticDimension
  }
  
  // MARK: - UIScroollViewDelegate Methods
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < 0 {
      scrollView.isScrollEnabled = false
      scrollView.isScrollEnabled = true
    }
  }
  
  // MARK: - Selector Methods
  @objc fileprivate func handleDismiss(button: UIButton) {
    button.isHidden = true
    dismissHandler?()
  }
  
  // MARK: - Helper Methods
  fileprivate func setupCloseButton() {
    view.addSubview(closeButton)
    closeButton.anchor(
      top: view.safeAreaLayoutGuide.topAnchor,
      leading: nil,
      bottom: nil,
      trailing: view.trailingAnchor,
      padding: .init(
        top: 12,
        left: 0,
        bottom: 0,
        right: 0
      ),
      size: .init(
        width: 80,
        height: 40
      )
    )
    closeButton.addTarget(
      self,
      action: #selector(handleDismiss),
      for: .touchUpInside
    )
  }
}
