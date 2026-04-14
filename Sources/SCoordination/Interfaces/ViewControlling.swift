//
//  ViewCoordinating.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 07.05.2024.
//

import UIKit

// MARK: - ViewControlling

public protocol ViewControlling {
    associatedtype RootViewController: UIViewController
    var rootViewController: RootViewController { get }
    
    func dismiss(animated: Bool, completion: (() -> Void)?)
    
    func dismissAll(animated: Bool, completion: (() -> Void)?)
}

public extension ViewControlling {
    
    /// A helper method for any ViewControlling to be able to present some other view controller with
    /// presentation guarantied to be performer on topmost view controller and without direct access to
    /// `rootViewController`
    func present(
        _ viewController: UIViewController,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        rootViewController
            .topmostViewContoller
            .present(
                viewController,
                animated: animated,
                completion: completion
            )
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        rootViewController.presentedViewController?.dismiss(animated: animated, completion: completion)
    }
    
    func dismissAll(animated: Bool, completion: (() -> Void)? = nil) {
        rootViewController.dismiss(animated: animated, completion: completion)
    }
    
}

// MARK: - AnyCoordinating

public typealias AnyCoordinator = Coordinating & ViewControlling
