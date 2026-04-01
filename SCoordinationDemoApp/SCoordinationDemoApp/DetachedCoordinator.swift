//
//  DetachedCoordinator.swift
//  SCoordinationDemoApp
//
//  Created by Ляпин Михаил on 01.04.2026.
//

import SCoordination

enum DetachedDestination: Destination {
    case initial
}

final class DetachedCoordinator: NavigationCoordinator<DetachedDestination> {
    
    override func prepareNavigationTransition(for destination: DetachedDestination) -> NavigationTransition {
        switch destination {
        case .initial:
                .setSingleViewController(DetachedViewController(router: unownedRouter))
        }
    }
    
}
