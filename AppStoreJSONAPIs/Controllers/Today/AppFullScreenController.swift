//
//  AppFullScreenController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/29.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {
  // MARK: - Instance Properties
  var dismissHandler: (() ->())?
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
  }
  
  // MARK: - UITableViewDataSource Methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.item == 0 {
      let headerCell = AppFullScreenHeaderCell()
      headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
      return headerCell
    }
    let cell = AppFullScreenDescriptionCell()
    return cell
  }
  
  // MARK: - UITableViewDelegate Methods
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 450
    }
    return super.tableView(tableView, heightForRowAt: indexPath)
  }
  
  // MARK: - Selector Methods
  @objc fileprivate func handleDismiss(button: UIButton) {
    button.isHidden = true
    dismissHandler?()
  }
}
