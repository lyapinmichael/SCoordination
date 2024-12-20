//
//  StrongRouter.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 11.05.2024.
//

import UIKit

public final class Router<DestinationType: Destination, RootViewController: UINavigationController>: Routing, DetachedTransitionHandling, ReferenceCounting {
    // MARK: Public properties
    
    public var rootViewController: UINavigationController
    
    public var referenceCounter: ReferenceCounter
    
    // MARK: Private properties

    private var _prepareNavigationTransition: (DestinationType) -> NavigationTransition
    private var _navigateTo: (DestinationType) -> Void
    private var _shouldStop: () -> Void
    private var _popToRoot: (Bool) -> Void
    private var _pop: (Bool) -> Void
    private var _dismiss: (Bool) -> Void
    
    // MARK: Init
    
    public init<T: Routing>(_ router: T, referenceCounter: ReferenceCounter) where T.DestinationType == DestinationType, T.RootViewController == UINavigationController {
        self.rootViewController = router.rootViewController
        self._navigateTo = router.navigateTo
        self._prepareNavigationTransition = router.prepareNavigationTransition
        self._shouldStop = router.shouldStop
        self._popToRoot = router.popToRoot
        self._pop = router.pop
        self._dismiss = router.dismiss
        self.referenceCounter = referenceCounter
        self.referenceCounter.listener = self
    }
    
    // MARK: Public methods
    
    public func navigateTo(_ destination: DestinationType) {
        _navigateTo(destination)
    }
    
    public func popToRoot(animated: Bool = true) {
        _popToRoot(animated)
    }
    
    public func pop(animated: Bool = true) {
        _pop(animated)
    }
    
    public func dismiss(animated: Bool = true) {
        _dismiss(animated)
    }
    
    public func prepareNavigationTransition(for destination: DestinationType) -> NavigationTransition {
        _prepareNavigationTransition(destination)
    }
    
    public func shouldStop() {
        _shouldStop()
    }
    
    public func onCountDidReachZero() {
        shouldStop()
    }
}
