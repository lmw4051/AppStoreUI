//
//  SearchResult.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
  let resultCount: Int
  let results: [Result]
}

struct Result: Decodable {
  let trackId: Int
  let trackName: String
  let primaryGenreName: String
  let averageUserRating: Float?
  let screenshotUrls: [String]
  let artworkUrl100: String
  var formattedPrice: String?
  let description: String
  var releaseNotes: String?
}
