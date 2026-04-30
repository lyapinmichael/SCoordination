//
//  DetachedNavigationCoordinator.swift
//  SCoordination
//
//  Created by Михаил Ляпин on 30.04.2026.
//

import UIKit

open class DetachedNavigationCoordinator<DestinationType: Destination>: BaseCoordinator, @MainActor ExtendedNavigationHandling {
 
    // MARK: Public properties
    
    public typealias RootViewController = UINavigationController
    
    public var rootViewController: UINavigationController { wrappedCoordinator.rootViewController }
    
    // MARK: Private properties
    
    private let underlayingViewController: UIViewController?
    private let wrappedCoordinator: NavigationCoordinator<DestinationType>
    
    // MARK: Init
    
    @MainActor
    public init(
        overlayOver viewController: UIViewController,
        wrappedCoordinator: NavigationCoordinator<DestinationType>,
    ) {
        self.wrappedCoordinator = wrappedCoordinator
        self.underlayingViewController = viewController
        
        underlayingViewController?.present(viewController, animated: false)
    }
    
    // MARK: Protocol reqiurements
    
    @MainActor
    public func prepareNavigationTransition(for destination: DestinationType) -> NavigationTransition {
        wrappedCoordinator.prepareNavigationTransition(for: destination)
    }
    
    open func shouldStop() {
        wrappedCoordinator.shouldStop()
    }
 
}

// MARK: Router

extension DetachedNavigationCoordinator where DetachedNavigationCoordinator: ReferenceCounting {
    public var unownedRouter: UnownedRouter<DestinationType> {
        UnownedRouter(wrappedCoordinator) { $0.strongRouter }
    }
}

