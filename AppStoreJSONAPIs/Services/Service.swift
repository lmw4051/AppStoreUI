//
//  Service.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/28.
//  Copyright © 2020 David. All rights reserved.
//

import Foundation

class Service {
  static let shared = Service()
  
  func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
    print("fetchApps")
    
    let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
    guard let url = URL(string: urlString) else { return }

    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        print("Failed to fetch apps:", error)
        completion([], nil)
        return
      }

      guard let data = data else { return }

      do {
        let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
        completion(searchResult.results, nil)
      } catch let error {
        print("Failed to decode json:", error)
        completion([], error)
      }
    }.resume()
  }
  
  func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
    guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json") else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(nil, error)
        return
      }
      
      guard let data = data else { return }
      
      do {
        let appGroup = try JSONDecoder().decode(AppGroup.self, from: data)
        appGroup.feed.results.forEach { print($0.name) }
        completion(appGroup, nil)
      } catch let error {
        completion(nil, error)
      }
    }.resume()
  }
}
