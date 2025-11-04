//
//  TabBarController.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 04.11.2025.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .black
    }

    private func setupTabs() {
        let homeScreen = createNavigation(with: "Home", and: UIImage(systemName: "house"), viewController: ViewController())
        let settingScreen = createNavigation(with: "Setting", and: UIImage(systemName: "gear"), viewController: SettingsViewController())
        
        self.setViewControllers([homeScreen, settingScreen], animated: true)
    }
    
    private func createNavigation(
        with title: String,
        and image: UIImage?,
        viewController: UIViewController
    ) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem.title = title
        navigation.tabBarItem.image = image
        
        return navigation
    }
}
