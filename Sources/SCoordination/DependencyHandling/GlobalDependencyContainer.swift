//
//  GlobalDependencyContainer.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 30.04.2024.
//

import Foundation

public struct GlobalDependencyContainer {
    private static var assemblers: [String: () -> Any] = [:]
    private static var cache: [String: Any] = [:]
}

extension GlobalDependencyContainer {
    /// Adds a dependency to a static dictionary that may be resolved since
    /// from any point of the app.
    ///
    /// - Parameters:
    ///     - type: a type of a dependency being registered.
    ///     - assembler: an autoclosure that declarates how this dependency
    ///     should be instantiated.
    public static func register<T>(type: T.Type, _ assembler: @autoclosure @escaping () -> T) {
        assemblers[String(describing: type.self)] = assembler
    }
    
    /// Resolves a previously registered dependency. If a dependency was not
    /// instantiated by the time it is attempted to resolve, it calls the
    /// `assembler` closure stores  newly created instance in cache and returns it.
    ///  Since that time whenever dependency is resolved again, it returns existing
    ///  instance from cache.
    ///
    ///  - Parameter type: a type of a dependency being resolved
    ///
    ///  - Warning: Attemting to resolve a dependency that was never registered
    ///  before (as well as if it was previously unregistered) leads to crash.
    public static func resolve<T>(_ type: T.Type) -> T? {
        let key = String(describing: T.self)
        if let cachedDependency = cache[key] as? T {
            return cachedDependency
        } else {
            return assemblers[key]?() as? T
        }
    }
    
    /// Deletes a particular dependency.
    ///
    ///  - Parameter type: a type of a dependency being unregistered
    ///
    ///  - Important: Make sure that unregistered dependency will never be
    ///  attempted to resolve again (unless it is re-registered).
    ///
    ///  - Warning: Attemting to resolve a  previously unregistered dependency
    /// leads to crash.
    public static func unregister<T>(_ type: T.Type) {
        let key = String(describing: T.self)
        assemblers.removeValue(forKey: key)
        cache.removeValue(forKey: key)
    }
    
    /// Deletes all previously registered dependencies.
    ///
    ///  - Important: Make sure that unregistered dependency will never be
    ///  attempted to resolve again (unless it is re-registered).
    ///
    ///  - Warning: Attemting to resolve a  previously unregistered dependency
    /// leads to crash.
    public static func clearAll() {
        assemblers = [:]
        cache = [:]
    }
}
