//
//  HomePageTarget.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.11.2025.
//

import Foundation
import Moya

enum HomePageTarget {
    case getText
}

extension HomePageTarget: BaseTargetType {
    var path: String {
        switch self {
        case .getText:
            "/texts"
        }
    }
    var task: Moya.Task {
        switch self {
        case .getText:
                .requestPlain
        }
    }
    
}
