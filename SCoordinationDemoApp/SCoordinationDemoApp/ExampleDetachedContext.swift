//
//  ExampleDetachedContext.swift
//  SCoordinationDemoApp
//
//  Created by Ляпин Михаил on 01.04.2026.
//

import SCoordination

enum ExampleReason: Reason {
    case moveToDetachedVS
    case moveToBaseTree
}

final class ExampleDetachedContext: DetachedContext<ExampleReason> {
    
    override func performDetachedTransition() {
        switch reason {
        case .moveToDetachedVS:
            DemoAppCoordinator.shared.shouldStartCoordinatedRootFlow(.detached)
        case .moveToBaseTree:
            DemoAppCoordinator.shared.shouldStartCoordinatedRootFlow(.main)
        }
    }
    
}

