//
//  DependencyContainter.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 30.04.2024.
//

import Foundation

public final class ModuleDependencyContainer {    
    private var dependencies: [String: AnyObject] = [:]
    
    public func register<T: AnyObject>(_ initializer: @autoclosure @escaping () -> T, withCustomKey key: String) {
        dependencies[key] = initializer()
    }
    
    public func register<T: AnyObject>(_ initializer: @autoclosure @escaping () -> T) {
        let id = String(describing: T.self)
        dependencies[id] = initializer()
    }
    
    public func resolve<T: AnyObject>(customKey: String, as type: T.Type) throws -> T {
        if let dependency = dependencies[customKey] as? T {
            return dependency
        } else {
            throw ModuleDependencyContainerError.dependencyUnregistered
        }
    }
    
    public func resolve<T: AnyObject>(_ type: T.Type) throws -> T {
        let id = String(describing: T.self)
        if let dependency = dependencies[id] as? T {
            return dependency
        } else {
            throw ModuleDependencyContainerError.dependencyUnregistered
        }
    }
    
    public func resolve<T: AnyObject>(withProvidedInitializer initializer: @autoclosure @escaping () -> T) -> T {
        let id = String(describing: T.self)
        if let dependency = dependencies[id] as? T {
            return dependency
        } else {
            let newDependency = initializer()
            dependencies[id] = newDependency
            return newDependency
        }
    }
    
    public func clearDependencies() {
        dependencies.removeAll()
    }
}

public enum ModuleDependencyContainerError: Error {
    case dependencyUnregistered
}

extension ModuleDependencyContainerError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .dependencyUnregistered: ">>>>> Trying to resolve previously unregistered dependency."
        }
    }
}
