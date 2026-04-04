//
//  DetachedContext.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 10.05.2024.
//

import Foundation

/// The most general meta-type requiring just a method to perform transtion. Is a main **purely-behavioural**
///  contract for every `DetachedTransitionHandling` type.
///
/// `DetachedTransitionHandling` will just fire-and-forget the implementation of `performDetahcedTransition`, not even knowing what exactly is happening under the hood.
public protocol DetachedContext {
    
    @MainActor
    func performDetachedTransition()
   
}

/// A thin wrapper providing default initializer
public protocol InstantiatableDetachedContext: DetachedContext {
    
    @MainActor
    init()
    
}

/// A special `DetachedContext` that may have different reasons, that are supposedly mentally tightly bound.
///
/// For example, after successful athorization coordinator may want to switch to new root flow, that may
/// differ depending on user type. In such cases specific user type may be implemented via enum (which itself
/// may have some assocated values for even more precise data passing) and be then passed to
/// `DetachedContextWithReason` as a reason. `DetachedTransitionHandling` then just calls
/// `performDetachedTransition` as usual.
public protocol DetachedContextWithReason: DetachedContext {
    
    /// **R** stands for Reason
    associatedtype R: Reason
    
    var reason: R { get }
    
    @MainActor
    init(reason: R)
    
}

/// A special variation of DetachedContext, which is told at init-time, that it's `DetachedTransitionHandling`
/// is some kind of a `ViewControlling` type, so the context is aware that there is a `rootViewController`.
///
/// Especially useful for handling cases like presenting alerts, or some modal presentations that happen outside
/// of main navigation tree.
public protocol SelfPerformingDetachedContext: DetachedContext {
    
    var performer: any ViewControlling { get }
    
    @MainActor
    init(performer: any ViewControlling)
    
}

/// A variation of `SelfPerformingDetachedContext` that also accepts some reason and so may vary
/// it's transition depending on which reason is passed.
public protocol SelfPerformingDetachedContextWithReason: DetachedContext {
    
    /// **R** stands for Reason
    associatedtype R: Reason
    
    var reason: R { get }
    var performer: any ViewControlling { get }
    
    @MainActor
    init(reason: R, performer: any ViewControlling)
    
}
