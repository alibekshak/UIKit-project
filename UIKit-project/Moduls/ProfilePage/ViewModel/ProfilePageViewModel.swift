//
//  ProfilePageViewModel.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 22.01.2026.
//

import Foundation

final class ProfilePageViewModel: ProfilePageOutput {
    var username: String = ""
    
    private let userDataManager: UserDataManagerProtocol
    
    init(userDataManager: UserDataManagerProtocol) {
        self.userDataManager = userDataManager
        self.username = userDataManager.getUsername() ?? ""
    }
    
    func saveUserName() {
        let trimmed = username.trimmingCharacters(in: .whitespacesAndNewlines)
        userDataManager.saveUsername(trimmed)
    }
    
    func clearUserName() {
        userDataManager.removeUsername()
        username = ""
    }
}
