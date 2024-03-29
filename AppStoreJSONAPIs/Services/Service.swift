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
  
  func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
    print("fetchApps")
    
    let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
    fetchGenericJSONData(urlString: urlString, completion: completion)
  }
  
  func fetchTopFree(completion: @escaping (AppGroup?, Error?) -> ()) {
    fetchAppGroup(urlString: "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json", completion: completion)
  }
  
  func fetchTopPaid(completion: @escaping (AppGroup?, Error?) -> ()) {
    fetchAppGroup(urlString: "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/50/apps.json", completion: completion)
  }
  
  func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
    fetchGenericJSONData(urlString: urlString, completion: completion)
  }
  
  func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
    let urlString = "https://api.letsbuildthatapp.com/appstore/social"
    fetchGenericJSONData(urlString: urlString, completion: completion)
  }
  
  func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(nil, error)
        return
      }
      
      guard let data = data else { return }
      
      do {
        let objects = try JSONDecoder().decode(T.self, from: data)
        completion(objects, nil)
      } catch let error {
        completion(nil, error)
      }
    }.resume()
  }
}
