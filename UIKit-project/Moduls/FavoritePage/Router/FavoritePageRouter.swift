//
//  FavoritePageRouter.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 15.12.2025.
//

import UIKit

class FavoritePageRouter: FavoritePageRouterInput {
    weak var viewController: UIViewController?
    
    private let dependencyManager = DependencyManager.shared
    
    func routToDetailInfoView(info: TextInfoDataModel) {
        let detailInfoAssebly: DetailInfoAssembly = dependencyManager.inject(DetailInfoAssembly.self)
        let createVC = detailInfoAssebly.assembly(item: info)
        
        viewController?.navigationController?.pushViewController(createVC, animated: true)
    }
}
