//
//  FavoritePageViewModel.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 15.12.2025.
//

import Foundation

final class FavoritePageViewModel {
    
    weak var view: FavoritePageInput?
    
    private let store: TextInfoStoreProtocol
    
    init(store: TextInfoStoreProtocol) {
        self.store = store
    }
    
    func fetchInfo() {
        if let storedInfo = try? store.fetchAll(), !storedInfo.isEmpty {
            view?.showStoredInfo(content: storedInfo)
        }
    }
}

// MARK: - FavoritePageOutput

extension FavoritePageViewModel: FavoritePageOutput {
    func loadStoredInfo() {
        fetchInfo()
    }
}
