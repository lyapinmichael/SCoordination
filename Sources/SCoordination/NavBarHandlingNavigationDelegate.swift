//
//  BarsHandlingNavigationDelegate.swift
//  SCoordination
//
//  Created by Михаил Ляпин on 01.05.2026.
//

import UIKit

open class NavBarHandlingNavigationDelegate: NSObject, UINavigationControllerDelegate{
    
    var onDidReachPlaceholderViewController: (() -> Void)?
    
    open func navigationController(
            _ navigationController: UINavigationController,
            willShow viewController: UIViewController,
            animated: Bool
        ) {
            let prefersHidden = viewController.shouldHideNavigationBar
            navigationController.setNavigationBarHidden(prefersHidden, animated: animated)
        }
    
    open func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if navigationController.viewControllers.count == 1 &&
            viewController is PlaceholderViewController {
            onDidReachPlaceholderViewController?()
        }
    }
    
}
