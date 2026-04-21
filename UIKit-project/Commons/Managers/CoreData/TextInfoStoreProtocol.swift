//
//  TextInfoStoreProtocol.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 15.12.2025.
//

import Foundation

protocol TextInfoStoreProtocol {
    func save(_ item: TextInfoData) throws
    func fetchAll() throws -> [TextInfoData]
    func deleteAll() throws
    func delete(_ item: TextInfoData) throws
    func exists(_ item: TextInfoData) throws -> Bool
}
