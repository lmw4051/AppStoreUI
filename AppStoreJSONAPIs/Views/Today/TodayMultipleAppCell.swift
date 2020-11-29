//
//  TodayMultipleAppCell.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/29.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
  // MARK: - Instance Properties
  override var todayItem: TodayItem! {
    didSet {
      categoryLabel.text = todayItem.category
      titleLabel.text = todayItem.title
    }
  }
  
  let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
  let titleLabel = UILabel(text: "Utilizing your time", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)
  
  let multipleAppsController = UIViewController()
  
  // MARK: - View Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    layer.cornerRadius = 16
    
    multipleAppsController.view.backgroundColor = .red
    
    let stackView = VerticalStackView(arrangedSubviews: [
      categoryLabel, titleLabel, multipleAppsController.view
    ], spacing: 12)
    
    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
