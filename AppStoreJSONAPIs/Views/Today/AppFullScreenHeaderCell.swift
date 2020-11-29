//
//  AppFullScreenHeaderCell.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/29.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppFullScreenHeaderCell: UITableViewCell {
  // MARK: - Instance Properties
  let todayCell = TodayCell()
  
  let closeButton: UIButton = {
      let button = UIButton(type: .system)
      button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
      return button
  }()
  
  // MARK: - View Life Cycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(todayCell)
    todayCell.fillSuperview()
    
    addSubview(closeButton)
    closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 12), size: .init(width: 80, height: 38))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
