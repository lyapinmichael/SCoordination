//
//  ExtendedNavigationHandling.swift
//  SCoordination
//
//  Created by Михаил Ляпин on 30.04.2026.
//

import UIKit

public protocol ExtendedNavigationHandling: Routing {
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
    
}

public extension ExtendedNavigationHandling where RootViewController == UINavigationController {
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        rootViewController.setViewControllers(viewControllers, animated: animated)
    }
    
}
