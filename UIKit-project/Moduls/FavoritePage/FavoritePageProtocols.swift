//
//  FavoritePageProtocols.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 15.12.2025.
//

import Foundation

protocol FavoritePageInput: AnyObject {
    func showStoredInfo(content: [TextInfoDataModel])
}

protocol FavoritePageOutput: AnyObject {
    func loadStoredInfo()
    func tapToDetailInfoView(infoData: TextInfoDataModel)
    func deleteFavorite(_ item: TextInfoDataModel)
    func deleteFavorites(_ items: [TextInfoDataModel])
}
