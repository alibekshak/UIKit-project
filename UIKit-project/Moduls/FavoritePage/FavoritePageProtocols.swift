//
//  FavoritePageProtocols.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 15.12.2025.
//

import Foundation

protocol FavoritePageInput: AnyObject {
    func showStoredInfo(content: [TextInfoData])
}

protocol FavoritePageOutput: AnyObject {
    func loadStoredInfo()
    func tapToDetailInfoView(infoData: TextInfoData)
    func deleteFavorite(_ item: TextInfoData)
}
