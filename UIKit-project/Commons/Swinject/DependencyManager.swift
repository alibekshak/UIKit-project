//
//  DependencyManager.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.12.2025.
//

import Swinject

final class DependencyManager: ModuleInjecting {
    static let shared = DependencyManager()
    
    let container: Container
    
    private init() {
        container = Container()
        registerServices()
        registerModules()
    }
    
    // Реализация протокола ModuleInjecting
    func inject<Dependency>(_ serviceType: Dependency.Type) -> Dependency {
        guard let resolved = container.resolve(serviceType) else {
            fatalError("Failed to resolve dependency: \(serviceType)")
        }
        return resolved
    }
}

private extension DependencyManager {
    func registerServices() -> Self {
        container.register(HomePageServiceProtocol.self) { _ in
            HomePageService()
        }
        .inObjectScope(.container)
        
        return self
    }
    
    func registerModules() -> Self {
        container.register(HomePageModuleAssembly.self) { [unowned self] _ in
            HomePageModuleAssembly(injection: self)
        }
        
        container.register(FavoritePageAssembly.self) { [unowned self] _ in
            FavoritePageAssembly(injection: self)
        }
        
        container.register(TextInfoStoreProtocol.self) { _ in
            TextInfoCoreDataStore()
        }.inObjectScope(.container)
        
        return self
    }
}


