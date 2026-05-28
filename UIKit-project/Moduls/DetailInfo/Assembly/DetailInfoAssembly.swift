//
//  DetailInfoAssembly.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 20.12.2025.
//

import UIKit

class DetailInfoAssembly: BaseModuleAssembly {
    func assembly(item: TextInfoDataModel) -> UIViewController {
        let viewControllers = DetailInfoViewController(item: item)
        let viewModel = DetailInfoViewModel(dateStore: injection.inject(TextInfoStoreProtocol.self))
        let store = injection.inject(TextInfoStoreProtocol.self)
        
        viewModel.view = viewControllers
        viewControllers.output = viewModel
        
        let isFavorite = (try? store.exists(item)) ?? false
        viewControllers.configureInitialFavoriteState(isFavorite: isFavorite)
        
        return viewControllers
    }
}
