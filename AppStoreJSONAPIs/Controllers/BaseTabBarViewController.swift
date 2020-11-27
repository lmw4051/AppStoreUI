//
//  BaseTabBarViewController.swift
//  AppStoreJSONAPIs
//
//  Created by David on 2020/11/27.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
            
    viewControllers = [
      createNavController(viewController: AppsSearchController(), title: "Search", imageName: "search"),
      createNavController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
      createNavController(viewController: UIViewController(), title: "Apps", imageName: "apps")      
    ]
  }
  
  fileprivate func createNavController(
    viewController: UIViewController,
    title: String,
    imageName: String) -> UIViewController {
    
    let navController = UINavigationController(rootViewController: viewController)
    navController.navigationBar.prefersLargeTitles = true
    viewController.navigationItem.title = title
    viewController.view.backgroundColor = .white
    navController.tabBarItem.title = title
    navController.tabBarItem.image = UIImage(named: imageName)
    
    return navController
  }
}
