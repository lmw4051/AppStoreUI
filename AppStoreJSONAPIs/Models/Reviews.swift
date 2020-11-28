//
//  Reviews.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import Foundation

struct Reviews: Decodable {
  let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
  let entry: [Entry]
}

struct Entry: Decodable {
  let author: Author
  let title: Label
  let content: Label
  
  let rating: Label
  
  private enum CodingKeys: String, CodingKey {
    case author, title, content
    case rating = "im:rating"
  }
}

struct Author: Decodable {
  let name: Label
}

struct Label: Decodable {
  let label: String
}
