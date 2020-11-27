//
//  SearchResultCell.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = .red
    iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
    iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
    iv.layer.cornerRadius = 12
    return iv
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "App Name"
    return label
  }()
  
  let categoryLabel: UILabel = {
    let label = UILabel()
    label.text = "Photos & Video"
    return label
  }()
  
  let ratingsLabel: UILabel = {
    let label = UILabel()
    label.text = "9.26M"
    return label
  }()
  
  let getButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("GET", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 14)
    button.backgroundColor = .darkGray
    button.widthAnchor.constraint(equalToConstant: 80).isActive = true
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .yellow
    
    let labelsStackView = UIStackView(arrangedSubviews: [
      nameLabel, categoryLabel, ratingsLabel
    ])
    labelsStackView.axis = .vertical
    
    let stackView = UIStackView(arrangedSubviews: [
      imageView, labelsStackView, getButton
    ])
    stackView.spacing = 12
    stackView.alignment = .center
    
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
