//
//  BaseTargetType.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.11.2025.
//

import Foundation
import Moya
internal import Alamofire

protocol BaseTargetType: TargetType {
}

extension BaseTargetType {
    nonisolated public var baseURL: URL {
        return BaseManagerURL.fakerapiURL
    }
    
    nonisolated public var path: String {
        return ""
    }
    
    nonisolated public var method: Moya.Method {
        return .get
    }
    
    nonisolated public var sampleData: Data {
        Data()
    }
    
    nonisolated public var headers: [String: String]? {
        var result: [String: String] = [
            "Content-Type": "application/json"
        ]
        
        return result
    }
    
    nonisolated public var validate: Bool {
        return true
    }
}
