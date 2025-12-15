//
//  FavoritePageRouter.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 15.12.2025.
//

import UIKit

class FavoritePageRouter: FavoritePageRouterInput {
    weak var viewController: UIViewController?
    
    func routToDetailInfoView(info: TextInfoData) {
        let vc = DetailInfoViewController(item: info)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
