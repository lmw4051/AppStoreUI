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
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.item == 0 {
      let cell = UITableViewCell()
      let todaycell = TodayCell()
      cell.addSubview(todaycell)
      todaycell.centerInSuperview(size: .init(width: 250, height: 250))
      return cell
    }
    let cell = AppFullScreenDescriptionCell()
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 450
  }
  
  // MARK: - UITableViewDelegate Methods
//  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    let header = TodayCell()
//    return header
//  }
//
//  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//    return 450
//  }
}
