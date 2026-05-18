//
//  SettingsPageModuleAssembly.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.01.2026.
//

import UIKit

class SettingsPageModuleAssembly: BaseModuleAssembly {
    func assemble() -> UIViewController {
        let viewControllers = SettingsViewController()
        let viewModel = SettingsViewModel(
             store: injection.inject(TextInfoStoreProtocol.self)
         )
        let router = SettingsViewRouter()
        
        viewModel.router = router
        viewControllers.output = viewModel
        router.viewController = viewControllers
        
        return viewControllers
    }
}
