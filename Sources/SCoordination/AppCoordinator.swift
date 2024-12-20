//
//  AppCoordinator.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 30.04.2024.
//

import UIKit

public enum AppCoordinatorType {
    case navigating
    case proxy
    case custom(ProxyingViewController)
}

/// This class is encouraged to be instantiated in SceneDelegate (AppDelegate) and to stay alive while
/// app is running.
open class AppCoordinator<RootFlowType: RootFlow>: BaseCoordinator {
    public static var shared: AppCoordinator<RootFlowType> {
        SharedStore.get(String(describing: RootFlowType.self))
    }
    
    public private(set) var rootViewController: ProxyingViewController
    
    // MARK: Private properties
    
    private let window: UIWindow?
    
    // MARK: Init
    
    public init(
        window: UIWindow?,
        type: AppCoordinatorType
    ) {
        self.window = window
        self.rootViewController = switch type {
        case .navigating:
            UINavigationController()
        case .proxy:
            ProxyViewController()
        case .custom(let proxyingViewController):
            proxyingViewController
        }
        super.init()
        SharedStore.add(self, forKey: String(describing: RootFlowType.self))
    }
    
    // MARK: Override
    
    // --- Final ---
    
    public final override func start() {
        window?.rootViewController = self.rootViewController
        window?.makeKeyAndVisible()
        appCoordinatorDidStart()
    }
    
    // MARK: Open methods
    
    // --- Overridable ----
    
    /// Do any additional setup by overriding this method.
    ///
    /// A good example of using this method is to call some methods needed
    /// a the very beginning of an app's lifecicle, before next coordinators
    /// will start, so the app can deside what to do next.
    open func appCoordinatorDidStart() {
        return
    }
    
    open func prepareCoordinator(for rootFlow: RootFlowType) -> any AnyCoordinator {
        fatalError("Please implement \(#function) method for setting up coordinators for app's root flows.")
    }
    // MARK: Public methods
    
    // --- Final ---
    
    public final func shouldStartCoordinatedRootFlow(
        _ rootFlow: RootFlowType,
        withOptions options: UIView.AnimationOptions? = nil,
        clearingGlobalDependencies: Bool = false
    ) {
        childCoordinators.forEach { childCoordinator in
            childCoordinator.stop()
        }
        let newRootCoordinator = prepareCoordinator(for: rootFlow)
        if clearingGlobalDependencies { GlobalDependencyContainer.clearAll() }
        addChild(newRootCoordinator)
        let newRootViewController = newRootCoordinator.rootViewController
        rootViewController.switchCurrent(to: newRootViewController, withOptions: options)
    }
    
    deinit {
        print("did deinit app coordinator where shouldn't")
    }
}
