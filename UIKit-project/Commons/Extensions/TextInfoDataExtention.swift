//
//  TextInfoDataExtention.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 15.12.2025.
//

import Foundation
import CryptoKit

extension TextInfoData {
    var stableId: String {
        let raw = "\(title ?? "")|\(author ?? "")|\(genre ?? "")|\(content ?? "")"
        let hash = SHA256.hash(data: Data(raw.utf8))
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
