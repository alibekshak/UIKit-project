//
//  ProfilePageViewModel.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 22.01.2026.
//

import Foundation

final class ProfilePageViewModel: ProfilePageOutput {
    var username: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    
    private let userDataManager: UserDataManagerProtocol
    
    init(userDataManager: UserDataManagerProtocol) {
        self.userDataManager = userDataManager
        self.username = userDataManager.getUsername() ?? ""
        self.phoneNumber = userDataManager.getPhone() ?? ""
        self.email = userDataManager.getEmail() ?? ""
    }
    
    // MARK: - Methods for userName
    
    func saveUserName() {
        let trimmed = username.trimmingCharacters(in: .whitespacesAndNewlines)
        userDataManager.saveUsername(trimmed)
    }
    
    func clearUserName() {
        userDataManager.removeUsername()
        username = ""
    }
    
    // MARK: - Methods for phone
    
    func savePhomeNumber() {
        let trimmed = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        userDataManager.savePhone(trimmed)
    }
    
    func clearPhoneNumber() {
        userDataManager.removePhone()
        phoneNumber = ""
    }
    
    // MARK: - Methpds for email
    
    func saveEmail() {
        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        userDataManager.saveEmail(trimmed)
    }
    
    func clearEmail() {
        userDataManager.removeEmail()
        email = ""
    }
}
