//
//  SettingsViewModel.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.01.2026.
//

import Foundation

final class SettingsViewModel: SettingsPageOutput {
    
    var router: SettingsViewRouter?
    
    func navigateToFavoritePage() {
        router?.routToFavoritePageView()
    }
    
    func navigateToProfilePage() {
        router?.routToProfilePage()
    }
}
