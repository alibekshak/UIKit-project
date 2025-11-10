//
//  HomePageServiceProtocol.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.11.2025.
//

import Foundation
import Moya

protocol HomePageServiceProtocol {
    func getTextInfo(completion: @escaping (Result<TextInfoResponseModel, MoyaError>) -> Void)
}
