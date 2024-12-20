//
//  NavigationTransition.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 09.05.2024.
//

import UIKit

public struct NavigationTransition {
    private let nextViewController: UIViewController
    private let animated: Bool
    private let navigationType: NavigationType
    
    /// Initializer of `NavigationTransition` is private as either
    /// `push(_:animated:)` or `present(_:animated:)` should be used instead to
    ///  instantiate a certain transition
    private init(nextViewController: UIViewController, animated: Bool, navigationType: NavigationType) {
        self.nextViewController = nextViewController
        self.animated = animated
        self.navigationType = navigationType
    }
    
    // MARK: Static methods:
    
    /// Use this method to create a new transition of 'pushing' type.
    ///
    /// Animated by default.
    ///
    /// - Parameters:
    ///     - viewController: A view controller that should be pushed to when
    ///     performing this transition.
    ///     - animated: Indicates if this transition should be animated. Default value is `true`.
    public static func push(_ viewController: UIViewController, animated: Bool = true) -> NavigationTransition {
        NavigationTransition(nextViewController: viewController,
                             animated: animated,
                             navigationType: .pushing)
    }
    
    /// Use this method to create a new transition of 'modal presentation' type.
    ///
    /// - Parameters:
    ///     - viewController: A view controller that should be presented when
    ///     performing this transition.
    ///     - presentationStyle: A modal presentation style for this transition.
    ///     - animated: Indicates if this transition should be animated.
    ///     - completion: A completion handler that will be executed after this
    ///     transition if performed.
    public static func present(_ viewController: UIViewController, presentationStyle: UIModalPresentationStyle, animated: Bool = true, completion: @escaping () -> Void = {}) -> NavigationTransition {
        NavigationTransition(nextViewController: viewController,
                             animated: animated,
                             navigationType: .modal(presentationStyle: presentationStyle,
                                                    completion: completion))
    }
    
    /// Use this method to create a new transition that resets whole hiearachy
    /// of view in navigation controller and sets just **one** new view controller.
    ///
    /// Not animated by default.
    ///
    /// - Parameters:
    ///     - viewController: A view controller that should be presented when
    ///     performing this transition.
    ///     - animated: Indicates if this transition should be animated. Is set
    ///     to `false` by default.
    public static func setSingleViewController(_ viewController: UIViewController, animated: Bool = false) -> NavigationTransition {
        NavigationTransition(nextViewController: viewController,
                             animated: animated,
                             navigationType: .setting)
    }
    
    // MARK: Public methods
    
    /// Use this method to perform this transition.
    ///
    /// - Parameter navigationController:
    ///     A navigation controller that should perform this transition.
    public func perform(on navigationController: UINavigationController) {
        switch navigationType {
        case .modal(let presentationStyle, let completion):
            nextViewController.modalPresentationStyle = presentationStyle
            navigationController.present(nextViewController,
                                         animated: animated,
                                         completion: completion)
        case .pushing:
            navigationController.pushViewController(nextViewController, 
                                                    animated: animated)
        case .setting:
            navigationController.setViewControllers([nextViewController],
                                                    animated: animated)
        }
    }    
}
