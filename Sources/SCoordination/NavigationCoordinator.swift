//
//  BaseCoordinator.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 30.04.2024.
//

import UIKit

open class NavigationCoordinator<DestinationType: Destination>: BaseCoordinator, @MainActor ExtendedNavigationHandling {
    
    public typealias RootViewController = UINavigationController
    
    // MARK: Public properties
    
    public private(set) var rootViewController: RootViewController
    
    // MARK: Private properties
    
    private var onStop: NavigationCompletion = .shouldClearViewHeirarchy
    
    // MARK: Init
    
    @MainActor
    public override init(sharedDependencyContainer: ModuleDependencyContainer? = nil, with preconditionData: [String: Any] = [:]) {
        self.rootViewController = UINavigationController()
        super.init(sharedDependencyContainer: sharedDependencyContainer, with: preconditionData)
    }
    
    @MainActor
    public init(rootViewController: UINavigationController, sharedDependencyContainer: ModuleDependencyContainer? = nil, with preconditionData: [String: Any] = [:], onStop: NavigationCompletion = .doNothing) {
        self.rootViewController = rootViewController
        super.init(sharedDependencyContainer: sharedDependencyContainer, with: preconditionData)
        self.onStop = onStop
    }
    
    @MainActor
    public init(
        over viewController: UIViewController,
        sharedDependencyContainer: ModuleDependencyContainer? = nil,
        with preconditionData: [String: Any] = [:]
    ) {
        self.rootViewController = UINavigationController()
        self.rootViewController.modalPresentationStyle = .overFullScreen
        self.onStop = .shouldDismiss(animated: false, completion: {})
        super.init(sharedDependencyContainer: sharedDependencyContainer, with: preconditionData)
        guard viewController.isViewLoaded else {
            assertionFailure("underlying controller's view should have already been loaded")
            return
        }
        viewController.present(self.rootViewController, animated: false)
    }
    
    // MARK: Open methods
    
    open override func start() {
        navigateTo(.initial)
    }
    
    @MainActor
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
        case .shouldDismiss(let animated, let completion):
            guard let presenter = rootViewController.presentingViewController else {
                assertionFailure("Expected presented UINavigationController")
                break
            }
            presenter.dismiss(animated: animated, completion: completion)
        case .doNothing:
            break
        }
        super.stop()
    }
    
    open func shouldStop() {
        stop()
    }
    
}

// MARK: Router

extension NavigationCoordinator where NavigationCoordinator: ReferenceCounting {
    public var unownedRouter: UnownedRouter<DestinationType> {
        UnownedRouter(self) { $0.strongRouter }
    }    
}
