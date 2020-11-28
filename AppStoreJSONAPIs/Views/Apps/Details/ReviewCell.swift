//
//  ReviewCell.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
  let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18))
  
  let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
  
  let starsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 14))
  
  let bodyLabel = UILabel(text: "Review body\nReview body\nReview body\n", font: .systemFont(ofSize: 16), numberOfLines: 0)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = #colorLiteral(red: 0.9423103929, green: 0.9410001636, blue: 0.9745038152, alpha: 1)
    layer.cornerRadius = 16
    clipsToBounds = true
    
    let stackView = VerticalStackView(arrangedSubviews: [
      UIStackView(arrangedSubviews: [
        titleLabel, authorLabel
      ], customSpacing: 8),
      starsLabel,
      bodyLabel
    ], spacing: 12)
    
    titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
    authorLabel.textAlignment = .right
    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
