//
//  DetailInfoViewModel.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 18.12.2025.
//

import Foundation

final class DetailInfoViewModel: DetailInfoOutput {
    
    weak var view: DetailInfoInput?
    private let dataStore: TextInfoStoreProtocol
    
    init(dateStore: TextInfoStoreProtocol) {
        self.dataStore = dateStore
    }
    
    func addToFavorite(data item: TextInfoData) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }

            // На всякий случай повторно проверим
            let isFavorite = (try? self.dataStore.exists(item)) ?? false
            guard !isFavorite else {
                DispatchQueue.main.async {
                    self.view?.setFavoriteButtonEnabled(false)
                    self.view?.setFavoriteButtonState(isFavorite: true)
                }
                return
            }

            do {
                try self.dataStore.save(item)
                DispatchQueue.main.async {
                    self.view?.setFavoriteButtonEnabled(false)
                    self.view?.setFavoriteButtonState(isFavorite: true)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func onViewDidLoad(item: TextInfoData) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            
            let isFavorite = (try? self.dataStore.exists(item)) ?? false
            
            DispatchQueue.main.async {
                self.view?.setFavoriteButtonEnabled(!isFavorite)
                self.view?.setFavoriteButtonState(isFavorite: isFavorite)
            }
        }
    }
}
