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
    func performDetachedTransition(_ context: DetachedContext)
}

public extension DetachedTransitionHandling {
    
    @MainActor
    public func performDetachedTransition(_ context: DetachedContext) {
        context.performDetachedTransition()
    }
    
}

public extension DetachedTransitionHandling where Self: ViewControlling {
    
    @MainActor
    func performDetachedTransitionOnSelf<
        C: SelfPerformingDetachedContext
    >(
        _ contextType: C.Type,
    ) {
        let context = C(performer: self)
        context.performDetachedTransition()
    }
    
    @MainActor
    func performDetachedTransitionOnSelf<
        C: SelfPerformingDetachedContextWithReason
    >(
        _ contextType: C.Type,
        reason: C.R
    ) {
        let context = C(reason: reason, performer: self)
        context.performDetachedTransition()
    }
    
}
