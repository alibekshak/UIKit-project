//
//  HomePageService.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.11.2025.
//

import Foundation
import Moya

final class HomePageService: HomePageServiceProtocol {
    private let provider: MoyaProvider<HomePageTarget>
    
    init(provider: MoyaProvider<HomePageTarget> = MoyaProvider<HomePageTarget>(
        plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging)]
    )) {
        self.provider = provider
    }
    
    func getTextInfo(completion: @escaping (Result<TextInfoResponseModel, Moya.MoyaError>) -> Void) {
        provider.request(.getText) { result in
            switch RequestDecoder.shared.decodeResult(result, for: TextInfoResponseModel.self) {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
