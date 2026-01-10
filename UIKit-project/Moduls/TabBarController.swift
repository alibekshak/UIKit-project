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
        self.tabBarSetting()
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
            viewController: createSettingsViewController()
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
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .systemBackground
        
        navigation.navigationBar.standardAppearance = appearance
        navigation.navigationBar.scrollEdgeAppearance = appearance
        navigation.navigationBar.compactAppearance = appearance
        
        return navigation
    }
    
    private func tabBarSetting() {
        self.tabBar.tintColor = .blue
        self.tabBar.unselectedItemTintColor = .black
    }
    
    // MARK: - ViewController creation methods
    
    private func createHomePageViewController() -> UIViewController {
        let homeAssembly: HomePageModuleAssembly = DependencyManager.shared.inject(HomePageModuleAssembly.self)
        let viewControllers = homeAssembly.assemble()
        
        return viewControllers
    }
    
    private func createSettingsViewController() -> UIViewController {
        let homeAssembly: SettingsPageModuleAssembly = DependencyManager.shared.inject(SettingsPageModuleAssembly.self)
        let viewControllers = homeAssembly.assemble()
        
        return viewControllers
    }
}
