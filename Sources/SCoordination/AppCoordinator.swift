//
//  AppCoordinator.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 30.04.2024.
//

import UIKit

@available(*, deprecated, message: "will be deleted in future versions")
public enum AppCoordinatorType {
    case navigating
    case proxy
    case custom(ProxyingViewController)
}

/// This class is encouraged to be instantiated in SceneDelegate (AppDelegate) and to stay alive while
/// app is running.
open class AppCoordinator<RootFlowType: RootFlow>: BaseCoordinator {
    
    // MARK: Public properties
    
    public static var shared: AppCoordinator<RootFlowType> {
        SharedStore.get(String(describing: RootFlowType.self))
    }
    
    public let window: UIWindow?
    
    // MARK: Init
    
    @MainActor
    public init(
        window: UIWindow?,
        type: AppCoordinatorType
    ) {
        self.window = window
        super.init()
        SharedStore.add(self, forKey: String(describing: RootFlowType.self))
    }
    
    // MARK: Override
    
    // --- Final ---
    
    @MainActor
    public final override func start() {
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
    @MainActor
    open func appCoordinatorDidStart() {
        return
    }
    
    @MainActor
    open func prepareCoordinator(for rootFlow: RootFlowType) -> any AnyCoordinator {
        fatalError("Please implement \(#function) method for setting up coordinators for app's root flows.")
    }
    
    // MARK: Public methods
    
    // --- Final ---
    
    @MainActor
    public final func startRootFlow(
        _ rootFlow: RootFlowType,
        transitionDuration: TimeInterval = 0.3,
        withOptions options: UIView.AnimationOptions = [],
        clearingGlobalDependencies: Bool = false
    ) {
        childCoordinators.forEach { childCoordinator in
            childCoordinator.stop()
        }
        let newRootCoordinator = prepareCoordinator(for: rootFlow)
        if clearingGlobalDependencies { GlobalDependencyContainer.clearAll() }
        addChild(newRootCoordinator)
        let newRootViewController = newRootCoordinator.rootViewController
        guard let window else {
            assertionFailure("should have passed a window for proper app coordination")
            return
        }
        UIView.transition(with: window, duration: 0.2, options: options) {
            self.window?.rootViewController = newRootViewController
        }
    }
    
    @available(*, deprecated, renamed: "startRootFlow", message: "will be deleted in future versions")
    @MainActor
    public final func shouldStartCoordinatedRootFlow(
        _ rootFlow: RootFlowType,
        transitionDuration: TimeInterval = 0.3,
        withOptions options: UIView.AnimationOptions = [],
        clearingGlobalDependencies: Bool = false
    ) {
        startRootFlow(
            rootFlow,
            transitionDuration: transitionDuration,
            withOptions: options,
            clearingGlobalDependencies: clearingGlobalDependencies
        )
    }
        
}
