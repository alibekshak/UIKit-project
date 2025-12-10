//
//  HomePageModuleAssembly.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.12.2025.
//

import UIKit

class HomePageModuleAssembly: BaseModuleAssembly {
    func assemble() -> UIViewController {
        let viewControllers = HomePageViewController()
        let viewModel = HomePageViewModel(homePageService: injection.inject(HomePageServiceProtocol.self))
        let router = HomePageRouter()
        
        viewModel.view = viewControllers
        viewModel.router = router
        viewControllers.output = viewModel
        router.viewController = viewControllers
        
        return viewControllers
    }
}
