//
//  DetailInfoAssembly.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 20.12.2025.
//

import UIKit

class DetailInfoAssembly: BaseModuleAssembly {
    func assembly(item: TextInfoData) -> UIViewController {
        let viewControllers = DetailInfoViewController(item: item)
        let viewModel = DetailInfoViewModel(dateStore: injection.inject(TextInfoStoreProtocol.self))
        
        viewModel.view = viewControllers
        viewControllers.output = viewModel
        
        return viewControllers
    }
}
