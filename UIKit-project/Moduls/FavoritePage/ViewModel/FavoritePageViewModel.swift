//
//  FavoritePageViewModel.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 15.12.2025.
//

import Foundation

final class FavoritePageViewModel: FavoritePageOutput {
    
    weak var view: FavoritePageInput?
    var router: FavoritePageRouterInput?
    
    private let store: TextInfoStoreProtocol
    
    init(store: TextInfoStoreProtocol) {
        self.store = store
    }
    
    func loadStoredInfo() {
        let stored = (try? store.fetchAll()) ?? []
        view?.showStoredInfo(content: stored)
    }
    
    func tapToDetailInfoView(infoData: TextInfoData) {
        router?.routToDetailInfoView(info: infoData)
    }
}
