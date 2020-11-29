//
//  TodayItem.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/29.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

struct TodayItem {
  let category: String
  let title: String
  let image: UIImage
  let description: String
  let backgroundColor: UIColor
  
  let cellType: CellType
  
  let apps: [FeedResult]
  
  enum CellType: String {
    case single, multiple
  }
}
