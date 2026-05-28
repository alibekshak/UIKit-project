//
//  HomePageProtocols.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 01.12.2025.
//

import Foundation

protocol HomePageInput: AnyObject {
    func setLoading(_ isLoading: Bool)
    func showError(_ message: String)
    func showInfo(content: [TextInfoDataModel])
}

protocol HomePageOutput: AnyObject {
    func loadInfo()
    func tapToDetailInfoView(infoData: TextInfoDataModel)
    func navigateToFavoritePage()
}
