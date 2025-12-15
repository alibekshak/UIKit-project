//
//  TextInfoStoreProtocol.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 15.12.2025.
//

import Foundation

protocol TextInfoStoreProtocol {
    func save(_ items: [TextInfoData]) throws
    func fetchAll() throws -> [TextInfoData]
    func deleteAll() throws
}
