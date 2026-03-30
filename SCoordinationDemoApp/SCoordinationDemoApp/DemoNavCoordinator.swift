//
//  Untitled.swift
//  SCoordinationDemoApp
//
//  Created by Ляпин Михаил on 30.03.2026.
//

import SCoordination
internal import UIKit

enum DemoNavDestination: Destination {
    case initial
    case level1
    case level2
}

final class DemoNavCoordinator: NavigationCoordinator<DemoNavDestination> {
    
    
    override func prepareNavigationTransition(for destination: DemoNavDestination) -> NavigationTransition {
        switch destination {
        case .initial:
                .setSingleViewController(ViewController(router: unownedRouter))
        case .level1:
                .push(VCLevel1(router: unownedRouter))
        case .level2:
                .push(VCLevel2(router: unownedRouter))
        }
    }
    
}
