//
//  RequestDecoder.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.11.2025.
//

import Foundation
import Moya

final class RequestDecoder {
    static let shared = RequestDecoder()
    private init() {}
    
    func decodeResult<T: Decodable>(
        _ result: Result<Moya.Response, MoyaError>,
        for type: T.Type,
        decodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    ) -> Result<T, MoyaError> {
        switch result {
        case .success(let response):
            guard (200..<300).contains(response.statusCode) else {
                return .failure(.statusCode(response))
            }
            
            do {
                let decoded = try makeDecoder(decodingStrategy).decode(T.self, from: response.data)
                return .success(decoded)
            } catch {
                return .failure(.objectMapping(error, response))
            }
        case .failure(let moyaError):
            return .failure(moyaError)
        }
    }
    
    func decodeVoidResult(_ result: Result<Moya.Response, MoyaError>) -> Result<Void, MoyaError> {
        switch result {
        case .success(let response):
            do {
                _ = try response.filterSuccessfulStatusCodes()
                return .success(())
            } catch let moyaError as MoyaError {
                return .failure(moyaError)
            } catch {
                return .failure(.underlying(error, response))
            }
        case .failure(let moyaError):
            return .failure(moyaError)
        }
    }
    
    private func makeDecoder(_ strategy: JSONDecoder.KeyDecodingStrategy) -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = strategy
        return decoder
    }
}
