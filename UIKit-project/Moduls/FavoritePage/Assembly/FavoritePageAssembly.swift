//
//  FavoritePageAssembly.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 15.12.2025.
//

import UIKit

class FavoritePageAssembly: BaseModuleAssembly {
    func assembly() -> UIViewController {
        let viewControllers = FavoritePageViewController()
        let viewModel = FavoritePageViewModel(store: injection.inject(TextInfoStoreProtocol.self))
        let router = FavoritePageRouter()
        
        viewModel.view = viewControllers
        viewModel.router = router
        viewControllers.output = viewModel
        router.viewController = viewControllers
        
        return viewControllers
    }
}
