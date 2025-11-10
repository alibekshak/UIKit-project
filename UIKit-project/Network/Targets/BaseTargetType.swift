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
    public var baseURL: URL {
        return BaseManagerURL.fakerapiURL
    }
    
    public var path: String {
        return ""
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        Data()
    }
    
    public var headers: [String: String]? {
        var result: [String: String] = [
            "Content-Type": "application/json"
        ]
        
        return result
    }
    
    public var validate: Bool {
        return true
    }
}
