//
//  HomePageRouter.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 09.12.2025.
//

import UIKit

class HomePageRouter: HomePageRouterInput {
    
    weak var viewController: UIViewController?
    
    private let dependencyManager = DependencyManager.shared
    
    func routToDetailInfoView(info: TextInfoData) {
        let detailInfoAssebly: DetailInfoAssembly = dependencyManager.inject(DetailInfoAssembly.self)
        let createVC = detailInfoAssebly.assembly(item: info)
        
        viewController?.navigationController?.pushViewController(createVC, animated: true)
    }
    
    func routToFavoritePageView() {
        let favoritePageAssembly: FavoritePageAssembly = dependencyManager.inject(FavoritePageAssembly.self)
        let createdVC = favoritePageAssembly.assembly()
        
        createdVC.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(createdVC, animated: true)
    }
}
