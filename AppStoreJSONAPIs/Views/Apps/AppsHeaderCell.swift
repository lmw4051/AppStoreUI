//
//  AppsHeaderCell.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
  // MARK: - View Properties
  let companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
  
  let titleLabel = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 24))
  
  let imageView = UIImageView(cornerRadius: 8)
  
  // MARK: - View Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    companyLabel.textColor = .blue
    titleLabel.numberOfLines = 2
    
    let stackView = VerticalStackView(arrangedSubviews: [
      companyLabel, titleLabel, imageView
    ], spacing: 12)
    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
