//
//  DependencyWrapper.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 30.04.2024.
//

import Foundation

@propertyWrapper
struct Dependency<T> {
    var dependency: T
    
    init() {
        guard let dependency = GlobalDependencyContainer.resolve(T.self) else {
            fatalError("Dependency \(T.self) was attemted to resolve but was never registered")
        }
        self.dependency = dependency
    }
    
    var wrappedValue: T {
        get { dependency }
        set { dependency = newValue }
    }
}
