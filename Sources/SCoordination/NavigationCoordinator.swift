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
    private let navigationDelegate: UINavigationControllerDelegate
    
    // MARK: Init
    
    @MainActor
    public required override init(sharedDependencyContainer: ModuleDependencyContainer? = nil, with preconditionData: [String: Any] = [:]) {
        self.rootViewController = UINavigationController()
        let navigationDelegate = NavBarHandlingNavigationDelegate()
        self.navigationDelegate = navigationDelegate
        self.rootViewController.delegate = self.navigationDelegate
        super.init(sharedDependencyContainer: sharedDependencyContainer, with: preconditionData)
        navigationDelegate.onDidReachPlaceholderViewController = { [weak self] in
            guard let self else { return }
            self.shouldStop()
        }
    }
    
    @MainActor
    public init(
        rootViewController: UINavigationController? = nil,
        navigationDelegate: UINavigationControllerDelegate = NavBarHandlingNavigationDelegate(),
        sharedDependencyContainer: ModuleDependencyContainer? = nil,
        with preconditionData: [String: Any] = [:],
        onStop: NavigationCompletion = .doNothing
    ) {
        self.rootViewController = rootViewController ?? UINavigationController()
        self.navigationDelegate = navigationDelegate
        self.rootViewController.delegate = self.navigationDelegate
        self.onStop = onStop
        super.init(sharedDependencyContainer: sharedDependencyContainer, with: preconditionData)
        (navigationDelegate as? NavBarHandlingNavigationDelegate)?.onDidReachPlaceholderViewController = { [weak self] in
            guard let self else { return }
            self.shouldStop()
        }
    }
    
    @MainActor
    public static func withContainerController(
        sharedDependencyContainer: ModuleDependencyContainer? = nil,
        with preconditionData: [String : Any] = [:],
        onStop: NavigationCompletion = .shouldDismiss(animated: false)
    ) -> Self {
        let coordinator = Self(sharedDependencyContainer: sharedDependencyContainer, with: preconditionData)
        coordinator.onStop = onStop
        let placeholderViewController = PlaceholderViewController()
        coordinator.rootViewController.setViewControllers([placeholderViewController], animated: false)
        coordinator.rootViewController.modalPresentationStyle = .overFullScreen
        return coordinator
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
    
    /// **NOTE**: Should always call `super.shouldStop` when overriding this method.
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
