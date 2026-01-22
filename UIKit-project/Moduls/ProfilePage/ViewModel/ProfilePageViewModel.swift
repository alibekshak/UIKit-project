//
//  ProfilePageViewModel.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 22.01.2026.
//

import Foundation

final class ProfilePageViewModel {
    var username: String = ""
    
    private let userDataManager: UserDataManagerProtocol
    
    init(userDataManager: UserDataManagerProtocol) {
        self.userDataManager = userDataManager
        self.username = userDataManager.getUsername() ?? ""
    }
    
    func save() {
        let trimmed = username.trimmingCharacters(in: .whitespacesAndNewlines)
        userDataManager.saveUsername(trimmed)
    }
    
    func clearUserName() {
        userDataManager.removeUsername()
        username = ""
    }
}
