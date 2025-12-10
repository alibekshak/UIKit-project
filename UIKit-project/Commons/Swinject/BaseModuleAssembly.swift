//
//  BaseModuleAssembly.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.12.2025.
//

import Foundation
import Swinject

class BaseModuleAssembly {
    var injection: ModuleInjecting
    
    required init(injection: ModuleInjecting) {
        self.injection = injection
    }
}

protocol ModuleInjecting {
    func inject<Dependency>(_ serviceType: Dependency.Type) -> Dependency
}
