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
}

final class DemoAppCoordinator: AppCoordinator<DemoAppRootFlow> {
    
    override func prepareCoordinator(for rootFlow: DemoAppRootFlow) -> any AnyCoordinator {
        switch rootFlow {
        case .main:
            DemoNavCoordinator(rootViewController: rootViewController as! UINavigationController)
        }
    }
    
    override func appCoordinatorDidStart() {
        shouldStartCoordinatedRootFlow(.main)
    }
    
}
