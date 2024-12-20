//
//  ReferenceCounting.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 30.04.2024.
//

import Foundation

public protocol ReferenceOperatable: AnyObject {
    /// Unary operator provided as a conviniet way to increment count of references.
    static postfix func ++ (_ refCounter: Self)
    
    /// Unary operator provided as a conviniet way to decrement count of references.
    static postfix func -- (_ refCounter: Self)    
}
