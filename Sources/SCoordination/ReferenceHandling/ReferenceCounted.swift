//
//  CoordinatorWrapper.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 01.05.2024.
//

import Foundation

/// Used to wrap some object that is referring some other object
/// when this reference is desired to be counted by explicitly given
/// `ReferenceCounter`
@propertyWrapper
public final class ReferenceCounted<T: ReferenceCounting> {
    public var wrappedValue: T
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.wrappedValue.referenceCounter++
    }
    
    deinit {
        wrappedValue.referenceCounter--
    }    
}
