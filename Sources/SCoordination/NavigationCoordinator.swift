//
//  BaseCoordinator.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 30.04.2024.
//

import UIKit

open class NavigationCoordinator<DestinationType: Destination>: BaseCoordinator, ViewControlling, Routing {
    public typealias RootViewController = UINavigationController
    
    // MARK: Public properties
    
    public private(set) var rootViewController: RootViewController
    
    // MARK: Private properties
    
    private var onStop: NavigationCompletion = .shouldClearViewHeirarchy
    
    // MARK: Init
    
    public override init(sharedDependencyContainer: ModuleDependencyContainer? = nil, with preconditionData: [String: Any] = [:]) {
        self.rootViewController = UINavigationController()
        super.init(sharedDependencyContainer: sharedDependencyContainer, with: preconditionData)
    }
    
    public init(rootViewController: UINavigationController, sharedDependencyContainer: ModuleDependencyContainer? = nil, with preconditionData: [String: Any] = [:], onStop: NavigationCompletion = .doNothing) {
        self.rootViewController = rootViewController
        super.init(sharedDependencyContainer: sharedDependencyContainer, with: preconditionData)
        self.onStop = onStop
    }
    
    // MARK: Open methods
    
    open override func start() {
        navigateTo(.initial)
    }
    
    open func prepareNavigationTransition(for destination: DestinationType) -> NavigationTransition {
        fatalError("Please implement \(#function) method for setting up navigation from NavigationCoordinator.")
    }
    
    // MARK: Public methods
    
    public override func stop() {
        switch onStop {
        case .shouldClearViewHeirarchy:
            rootViewController.viewControllers.removeAll()
        case .shouldPopLastViewController(let animated):
            rootViewController.presentedViewController?.dismiss(animated: animated)
            rootViewController.popViewController(animated: animated)
        case .doNothing:
            break
        }
        super.stop()
    }
    
    public func shouldStop() {
        stop()
    }
    
    public enum NavigationCompletion {
        case shouldClearViewHeirarchy
        case shouldPopLastViewController(animated: Bool)
        case doNothing
    }
}

// MARK: Router

extension NavigationCoordinator where NavigationCoordinator: ReferenceCounting {
    public var unownedRouter: UnownedRouter<DestinationType> {
        UnownedRouter(self) { $0.strongRouter }
    }    
}
