//
//  UnownedNavigatoinCoordinator.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 10.05.2024.
//

import UIKit

// MARK: - UnownedRouter

public typealias UnownedRouter<DestinationType: Destination> = Unowned<Router<DestinationType, UINavigationController>>


// MARK: - ViewControlling

extension Unowned: ViewControlling where Value: ViewControlling {
    public var rootViewController: Value.RootViewController {
        wrappedValue.rootViewController
    }
}

// MARK: - Routing

extension Unowned: Routing where Value: Routing {
    public func navigateTo(_ destination: Value.DestinationType) {
        wrappedValue.navigateTo(destination)
    }
    
    public func popToRoot(animated: Bool = true) {
        wrappedValue.popToRoot(animated: animated)
    }
    
    public func pop(animated: Bool = true) {
        wrappedValue.pop(animated: animated)
    }
    
    public func dismiss(animated: Bool = true) {
        wrappedValue.dismiss(animated: animated)
    }
    
    public func prepareNavigationTransition(for destination: Value.DestinationType) -> NavigationTransition {
        wrappedValue.prepareNavigationTransition(for: destination)
    }
}

// MARK: - DetachedTransitionHandling

extension Unowned: DetachedTransitionHandling where Value: Routing {
    public func performDetachedTransition(_ context: DetachedContext<some Reason>) {
        wrappedValue.performDetachedTransition(context)
    }
    
    public func shouldStop() {
        wrappedValue.shouldStop()
    }
}

// MARK: - Reference counting

extension Unowned: ReferenceCounting where Value: ReferenceCounting {
    public var referenceCounter: ReferenceCounter {
        wrappedValue.referenceCounter
    }
}

extension Unowned: ReferenceCounterListening where Value: ReferenceCounterListening {
    public func onCountDidReachZero() {
        wrappedValue.onCountDidReachZero()
    }
}
