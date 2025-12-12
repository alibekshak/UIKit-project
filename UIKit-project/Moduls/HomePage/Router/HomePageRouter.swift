//
//  HomePageRouter.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 09.12.2025.
//

import UIKit

class HomePageRouter: HomePageRouterInput {
    
    weak var viewController: UIViewController?
    
    func routToDetailInfoView(info: TextInfoData) {
        let vc = DetailInfoViewController(item: info)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routToFavoritePageView() {
        let vc = FavoritePageViewController()
        vc.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
