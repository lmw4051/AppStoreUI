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
}
