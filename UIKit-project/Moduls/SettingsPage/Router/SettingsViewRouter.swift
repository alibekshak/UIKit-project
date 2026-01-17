//
//  SettingsViewRouter.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.01.2026.
//

import UIKit

class SettingsViewRouter: SettingsViewRouterInput {
    
    weak var viewController: UIViewController?
    
    private let dependencyManager = DependencyManager.shared
    
    func routToFavoritePageView() {
        let favoritePageAssembly: FavoritePageAssembly = dependencyManager.inject(FavoritePageAssembly.self)
        let createdVC = favoritePageAssembly.assembly()
        
        createdVC.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(createdVC, animated: true)
    }
    
    func routToProfilePage() {
        let profilePageAssembly: ProfilePageModuleAssembly = dependencyManager.inject(ProfilePageModuleAssembly.self)
        let createdVC = profilePageAssembly.assemble()
        
        createdVC.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(createdVC, animated: true)
    }
}
