//
//  DetailInfoViewModel.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 18.12.2025.
//

import Foundation

final class DetailInfoViewModel: DetailInfoOutput {
    
    let dataStore: TextInfoStoreProtocol
    
    init(dateStore: TextInfoStoreProtocol) {
        self.dataStore = dateStore
    }
    
    func addToFavorite(data: TextInfoData) {
        try? dataStore.save(data)
    }
}
