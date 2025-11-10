//
//  TextInfoResponseModel.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.11.2025.
//

import Foundation

struct TextInfoResponseModel: Codable {
    let status: String?
    let code: Int?
    let locale: String?
    let seed: String?
    let total: Int?
    let data: [TextInfoData?]
}

struct TextInfoData: Codable {
    let title: String?
    let author: String?
    let genre: String?
    let content: String?
}
