//
//  ExampleDetachedContext.swift
//  SCoordinationDemoApp
//
//  Created by Ляпин Михаил on 01.04.2026.
//

internal import UIKit
import SCoordination

enum ExampleReason: Reason {
    case moveToDetachedVS
    case moveToBaseTree
}

struct ExampleDetachedContextWithReason: DetachedContextWithReason {
    
    var reason: ExampleReason
    
    func performDetachedTransition() {
        switch reason {
        case .moveToDetachedVS:
            DemoAppCoordinator.shared.startRootFlow(.detached)
        case .moveToBaseTree:
            DemoAppCoordinator.shared.startRootFlow(.main, withOptions: [.transitionFlipFromRight])
        }
    }
    
}

