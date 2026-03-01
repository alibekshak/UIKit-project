//
//  ProfilePageModuleAssembly.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 17.01.2026.
//

import UIKit

class ProfilePageModuleAssembly: BaseModuleAssembly {
    func assemble() -> UIViewController {
        let viewControllers = ProfilePageViewController()
        let viewModel = ProfilePageViewModel(userDataManager: injection.inject(UserDataManagerProtocol.self))
        
        viewControllers.output = viewModel
        
        return viewControllers
    }
}
