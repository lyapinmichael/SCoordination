//
//  NavigationTransition.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 09.05.2024.
//

import UIKit

public struct NavigationTransition {
    private let animated: Bool
    private let navigationType: NavigationType
    
    /// Initializer of `NavigationTransition` is private as either
    /// `push(_:animated:)` or `present(_:animated:)` should be used instead to
    ///  instantiate a certain transition
    private init(animated: Bool, navigationType: NavigationType) {
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
        NavigationTransition(
            animated: animated,
            navigationType: .push(viewController)
        )
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
    public static func present(_ viewController: UIViewController, presentationStyle: UIModalPresentationStyle? = nil, animated: Bool = true, completion: @escaping () -> Void = {}) -> NavigationTransition {
        NavigationTransition(
            animated: animated,
            navigationType: .modal(
                viewController,
                presentationStyle: presentationStyle ?? viewController.modalPresentationStyle,
                completion: completion
            )
        )
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
    @available(*, deprecated, message: "should use `setViewControllers` instead")
    public static func setSingleViewController(
        _ viewController: UIViewController,
        animated: Bool = false
    ) -> NavigationTransition {
        NavigationTransition(
            animated: animated,
            navigationType: .set([viewController])
        )
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
    ///     - canPopFromRoot: a special flag, which if set to `true` adds `PlaceholderViewController`
    ///     as a root of new navigation stack, so the root view controller it has a back button and can pop to
    ///     a translucent placeholder view, which then tells coordinator to stop.
    public static func setViewControllers(
        _ viewControllers: [UIViewController],
        animated: Bool = false,
        canPopFromRoot: Bool = false,
        rootBackButtonParameters: BackButtonParameters = .systemDefault
    ) -> NavigationTransition {
        NavigationTransition(
            animated: animated,
            navigationType: .set(
                canPopFromRoot
                ? [PlaceholderViewController(rootBackButtonParameters: rootBackButtonParameters)] + viewControllers
                : viewControllers
            )
        )
    }
    
    // MARK: Public methods
    
    /// Use this method to perform this transition.
    ///
    /// - Parameter navigationController:
    ///     A navigation controller that should perform this transition.
    public func perform(on navigationController: UINavigationController) {
        switch navigationType {
        case .modal(let nextViewController, let presentationStyle, let completion):
            nextViewController.modalPresentationStyle = presentationStyle
            navigationController
                .topmostViewContoller
                .present(
                    nextViewController,
                    animated: animated,
                    completion: completion
                )
        case .push(let nextViewController):
            gracefully(on: navigationController) {
                navigationController.pushViewController(
                    nextViewController,
                    animated: animated
                )
            }
        case .set(let viewControllers):
            gracefully(on: navigationController) {
                navigationController.setViewControllers(
                    viewControllers,
                    animated: animated
                )
            }
        }
    }
    
    private func gracefully(on navigationController: UINavigationController, perform: @escaping () -> Void) {
        if let presented = navigationController.presentedViewController {
            presented.dismiss(animated: animated, completion: perform)
        } else {
            perform()
        }
    }
    
}
