//
//  TextInfoResponseModel.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.11.2025.
//

import Foundation
import CryptoKit

struct TextInfoResponseModel: Codable {
    let status: String?
    let code: Int?
    let locale: String?
    let seed: String?
    let total: Int?
    let data: [TextInfoDataModel]?
}

struct TextInfoDataModel: Codable {
    let title: String?
    let author: String?
    let genre: String?
    let content: String?
}

extension TextInfoDataModel {
    var stableId: String {
        let raw = "\(title ?? "")|\(author ?? "")|\(genre ?? "")|\(content ?? "")"
        let hash = SHA256.hash(data: Data(raw.utf8))
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
