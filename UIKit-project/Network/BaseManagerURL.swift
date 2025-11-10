//
//  BaseManagerURL.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.11.2025.
//

import Foundation

struct BaseManagerURL {
    nonisolated static var fakerapiURL: URL {
        guard let url = URL(string: "https://fakerapi.it/api/v2") else {
            fatalError("Invalid URL")
        }
        return url
    }
}
