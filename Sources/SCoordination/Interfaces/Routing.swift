//
//  Navigating.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 10.05.2024.
//

import UIKit

public protocol Routing: ViewControlling, DetachedTransitionHandling {
    /// A specific set of possible destinations that can be navigated to from this router.
    ///
    /// `Destination` is encouraget to be implemented with an enum.
    associatedtype DestinationType: Destination
    
    /// Call this method to perform a transition to another view controller.
    ///
    /// - Important:
    ///     Don't forget to prepare transitions with overide of
    ///     `prepareNavigationTransition(for:)` method first.
    func navigateTo(_ destination: DestinationType)
    
    func pop(animated: Bool)
    
    func popToRoot(animated: Bool)
    
    func dismiss(animated: Bool)
    
    /// Used to perform navigation with `UINavigationController` stored as
    /// `rootViewController` of `NavigationCoordinator`.
    ///
    /// This method is considered to be overriden in subclass `NavigationCoordinator`
    /// to handle all possible destinations from this coodinator. It is then
    /// called from within `navigateTo(_:)` method of this class, so navigation
    /// controller knows where to go next and how exactly to perform transition
    /// to next view controller.
    ///
    /// - Warning:
    ///     This method should be implemented in `NavigationContoller` subclasses.
    func prepareNavigationTransition(for destination: DestinationType) -> NavigationTransition
    
    func shouldStop()
}

extension Routing where RootViewController == UINavigationController {
    public func navigateTo(_ destination: DestinationType) {
        let transition = prepareNavigationTransition(for: destination)
        transition.perform(on: rootViewController)
    }
    
    public func popToRoot(animated: Bool) {
        rootViewController.popToRootViewController(animated: animated)
    }
    
    public func pop(animated: Bool) {
        rootViewController.popViewController(animated: animated)
    }
    
    public func dismiss(animated: Bool) {
        rootViewController.presentedViewController?.dismiss(animated: animated) 
    }
}

extension Routing where RootViewController == UINavigationController, Self: ReferenceCounting {
    public var strongRouter: Router<DestinationType, RootViewController> {
        Router(self, referenceCounter: self.referenceCounter)
    }    
}
