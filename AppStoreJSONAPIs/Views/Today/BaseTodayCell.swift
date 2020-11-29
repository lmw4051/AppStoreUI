//
//  BaseTodayCell.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/29.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class BaseTodayCell: UICollectionViewCell {
  // MARK: - Instance Properties
  var todayItem: TodayItem!
  
  override var isHighlighted: Bool {
    didSet {
      var transform: CGAffineTransform = .identity
      
      if isHighlighted {
        transform = .init(scaleX: 0.9, y: 0.9)
      }
      
      UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        self.transform = transform
      })
    }
  }
  
  // MARK: - View Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundView = UIView()
    
    addSubview(self.backgroundView!)
    self.backgroundView?.fillSuperview()
    self.backgroundView?.backgroundColor = .white
    self.backgroundView?.layer.cornerRadius = 16
    
    self.backgroundView?.layer.shadowOpacity = 0.25
    self.backgroundView?.layer.shadowRadius = 10
    self.backgroundView?.layer.shadowOffset = .init(width: 10, height: 10)
    
    // rasterizing the layer can improve the performance by not re-rendering the layer all the time. But it does this at the cost of memory (saving a rasterized image in memory).
    // But, if you animate a change within the layer, the shouldRasterize can adversely affect performance (because it's going to re-rasterize the layer for each frame of the animation).
    self.backgroundView?.layer.shouldRasterize = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
