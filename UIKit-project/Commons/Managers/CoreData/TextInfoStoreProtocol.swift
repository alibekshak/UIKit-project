//
//  TextInfoStoreProtocol.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 15.12.2025.
//

import Foundation

protocol TextInfoStoreProtocol {
    func save(_ item: TextInfoDataModel) throws
    func fetchAll() throws -> [TextInfoDataModel]
    func deleteAll() throws
    func delete(_ item: TextInfoDataModel) throws
    func exists(_ item: TextInfoDataModel) throws -> Bool
}
