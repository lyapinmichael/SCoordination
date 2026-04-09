//
//  DetachedTransitionHandler.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 11.05.2024.
//

import Foundation

public protocol DetachedTransitionHandling {
    /// Method handles a specific transition is a specified context that does not belong to any coordinator.
    ///
    /// This may be useful to call AppCoordinator from deeper places in coordination hierarchy whithout
    /// calling a chain of all the above parent coordinators.
    ///
    /// - Parameter context:
    ///     method takes some detached context in which it is specified how exactly a transition should
    ///     be performed.
    @available(*, deprecated, message: "Use overloads with provided context type")
    func performDetachedTransition(_ context: DetachedContext)
    
}

public extension DetachedTransitionHandling {
    
    @available(*, deprecated, message: "Use overloads with provided context type")
    @MainActor
    func performDetachedTransition(_ context: DetachedContext) {
        context.performDetachedTransition()
    }
    
}

public extension DetachedTransitionHandling {
    
    @MainActor
    func performDetachedTransition<C: InstantiatableDetachedContext>(
        _ contextType: C.Type
    ) {
        let context = contextType.init()
        context.performDetachedTransition()
    }
    
    @MainActor
    func performDetachedTransition<C: DetachedContextWithReason>(
        _ contextType: C.Type,
        reason: C.R
    ) {
        let context = contextType.init(reason: reason)
        context.performDetachedTransition()
    }
    
}

public extension DetachedTransitionHandling where Self: ViewControlling {
    
    @MainActor
    func performDetachedTransition<C: SelfPerformingDetachedContext>(
        _ contextType: C.Type,
    ) {
        let context = contextType.init(performer: self)
        context.performDetachedTransition()
    }
    
    @MainActor
    func performDetachedTransition<C: SelfPerformingDetachedContextWithReason>(
        _ contextType: C.Type,
        reason: C.R
    ) {
        let context = contextType.init(reason: reason, performer: self)
        context.performDetachedTransition()
    }
    
}
