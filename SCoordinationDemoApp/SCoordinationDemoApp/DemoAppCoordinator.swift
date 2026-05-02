//
//  DemoAppCoordinator.swift
//  SCoordinationDemoApp
//
//  Created by Ляпин Михаил on 30.03.2026.
//

internal import UIKit
import SCoordination

enum DemoAppRootFlow: RootFlow {
    case main
    case detached
}

final class DemoAppCoordinator: AppCoordinator<DemoAppRootFlow> {
    
    private let navController = UINavigationController()
    
    override func prepareCoordinator(for rootFlow: DemoAppRootFlow) -> any AnyCoordinator {
        switch rootFlow {
        case .main:
            DemoNavCoordinator(rootViewController: navController)
        case .detached:
            DetachedCoordinator(rootViewController: navController)
        }
    }
    
    override func appCoordinatorDidStart() {
        startRootFlow(.main)
    }
    
}
