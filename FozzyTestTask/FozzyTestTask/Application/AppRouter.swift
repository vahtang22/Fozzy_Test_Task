//
//  AppRouter.swift
//  FozzyTestTask
//
//  Created by Max Ivanets on 4/23/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

class AppRouter {
    static let shared = AppRouter()
    
    private init() {
    }
    
    func setupTabBar() -> UITabBarController {
        let vc1 = HomeViewController()
        vc1.configurator.configure(with: vc1)
        vc1.tabBarItem = UITabBarItem.init(title: "all", image: UIImage.init(named: "icons8-pikachu"), tag: 0)
        let vc2 = HomeViewController()
        vc2.configurator.configure(with: vc2, for: .fighting)
        vc2.tabBarItem = UITabBarItem.init(title: "fighting", image: UIImage.init(named: "icons8-abra"), tag: 1)
        let vc3 = HomeViewController()
        vc3.configurator.configure(with: vc3, for: .flying)
        vc3.tabBarItem = UITabBarItem.init(title: "flying", image: UIImage.init(named: "icons8-pidgey"), tag: 2)
        let vc4 = HomeViewController()
        vc4.configurator.configure(with: vc4, for: .ground)
        vc4.tabBarItem = UITabBarItem.init(title: "ground", image: UIImage.init(named: "icons8-bellsprout"), tag: 3)
        let vc5 = SettingsViewController()
        vc5.configurator.configure(with: vc5)
        vc5.tabBarItem = UITabBarItem.init(tabBarSystemItem: .more, tag: 4)
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = [UINavigationController.init(rootViewController: vc1),
                                  UINavigationController.init(rootViewController: vc2),
                                  UINavigationController.init(rootViewController: vc3),
                                  UINavigationController.init(rootViewController: vc4),
                                  UINavigationController.init(rootViewController: vc5)]
        return tabBar
    }
}
