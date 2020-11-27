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
    
    let redViewController = UIViewController()
    redViewController.view.backgroundColor = .white
    redViewController.navigationItem.title = "Apps"
    
    let redNavController = UINavigationController(rootViewController: redViewController)
    redNavController.tabBarItem.title = "Apps"
    redNavController.tabBarItem.image = #imageLiteral(resourceName: "apps")
    redNavController.navigationBar.prefersLargeTitles = true
    
    let blueViewController = UIViewController()
    blueViewController.view.backgroundColor = .white
    blueViewController.navigationItem.title = "Search"
    
    let blueNavController = UINavigationController(rootViewController: blueViewController)
    blueNavController.tabBarItem.title = "Search"
    blueNavController.navigationBar.prefersLargeTitles = true
    blueNavController.tabBarItem.image = #imageLiteral(resourceName: "search")
        
    viewControllers = [
      redNavController,
      blueNavController,
    ]
  }
}
