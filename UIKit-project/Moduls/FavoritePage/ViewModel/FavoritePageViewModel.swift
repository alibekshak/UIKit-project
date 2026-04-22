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
    
    func deleteFavorite(_ item: TextInfoData) {
        do {
            try store.delete(item)
            let updated = (try? store.fetchAll()) ?? []
            view?.showStoredInfo(content: updated)
        } catch {
            print("Failed to delete favorite: \(error)")
        }
    }
    
    func deleteFavorites(_ items: [TextInfoData]) {
        do {
            for item in items {
                try store.delete(item)
            }
            let updated = (try? store.fetchAll()) ?? []
            view?.showStoredInfo(content: updated)
        } catch {
            print("Failed to delete favorites: \(error)")
        }
    }
}
