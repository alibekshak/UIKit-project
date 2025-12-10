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
        
        self.tabBar.tintColor = .blue
        self.tabBar.unselectedItemTintColor = .black
    }
    
    private func setupTabs() {
        let homeScreen = createNavigation(
            with: "Home",
            and: UIImage(systemName: "house"),
            viewController: createHomePageViewController()
        )
        let settingScreen = createNavigation(
            with: "Setting",
            and: UIImage(systemName: "gear"),
            viewController: SettingsViewController()
        )
        
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
    
    private func createHomePageViewController() -> UIViewController {
        let homeAssembly: HomePageModuleAssembly = DependencyManager.shared.inject(HomePageModuleAssembly.self)
        let viewControllers = homeAssembly.assemble()
        
        return viewControllers
    }
}
