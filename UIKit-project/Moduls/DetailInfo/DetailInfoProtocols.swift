//
//  DetailInfoProtocols.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 18.12.2025.
//

import Foundation

protocol DetailInfoOutput: AnyObject {
    func addToFavorite(data: TextInfoData)
    func onViewDidLoad(item: TextInfoData)
}

protocol DetailInfoInput: AnyObject {
    func setFavoriteButtonEnabled(_ enabled: Bool)
    func setFavoriteButtonState(isFavorite: Bool)
}
