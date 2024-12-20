//
//  TabsCoordinator.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 07.05.2024.
//

import UIKit

/// `TabsCoordinator` is encourage to be a root coordinator of an entire app or
/// of a larger part of an app, designed to specifically contain either
/// coordinated or not coordinated modules within each tab.
///
/// This class is not designed to count references on itself, as it is not meant
/// to leave navigation stack while app (or less preferably a larger part of an
/// app) is running.
open class TabsCoordinator: BaseCoordinator, ViewControlling {
    public typealias RootViewController = UITabBarController
    
    // MARK: Public properties
    
    public var rootViewController: RootViewController
    
    // MARK: Init
    
    public override init(sharedDependencyContainer: ModuleDependencyContainer? = nil, with preconditionData: [String: Any] = [:]) {
        self.rootViewController = UITabBarController()
        super.init(sharedDependencyContainer: sharedDependencyContainer, with: preconditionData)
    }
    
    public init(rootViewController: UITabBarController, sharedDependencyContainer: ModuleDependencyContainer? = nil, with preconditionData: [String: Any] = [:]) {
        self.rootViewController = rootViewController
        super.init(sharedDependencyContainer: sharedDependencyContainer, with: preconditionData)
    }
    // MARK: Public methods
    
    /// Call this method for initial setup of a tabBarController, where each
    /// tab has it's own coordinator.
    ///
    /// It is recomended to pass no more than 5 tabs for a tabBarController
    ///
    /// - Parameter tabCoordinators:
    ///     Array of coordinators, each for a single tab of tabBar.
    public func setCoordinatedTabs(_ tabCoordinators: [any AnyCoordinator]) {
        var viewControllers = [UIViewController]()
        for tab in tabCoordinators {
            addChild(tab)
            viewControllers.append(tab.rootViewController)
        }
        rootViewController.viewControllers = viewControllers
    }
    
    override func didAddChild() {
        referenceCounter++
    }
    
    override func didRemoveChild() {
        referenceCounter--
    }

    public override func stop() {
        childCoordinators.forEach { $0.stop() }
        rootViewController.viewControllers = nil
        super.stop()
    }
}
