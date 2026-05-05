//
//  SettingsViewModel.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.01.2026.
//

import Foundation

final class SettingsViewModel: SettingsPageOutput {

    var router: SettingsViewRouter?
    let store: TextInfoStoreProtocol

     init(store: TextInfoStoreProtocol) {
         self.store = store
     }
    
    func navigateToFavoritePage() {
        router?.routToFavoritePageView()
    }
    
    func navigateToProfilePage() {
        router?.routToProfilePage()
    }
    
    func logout() {
        do {
            try store.deleteAll()
            router?.routeToHomePage()
        } catch {
            print("Failed to logout:", error)
        }
    }
}
