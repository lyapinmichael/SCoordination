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
    case present1
    case present2
    case compositePush
    case subcoordinator
}

final class DemoNavCoordinator: NavigationCoordinator<DemoNavDestination> {
    
    override func prepareNavigationTransition(for destination: DemoNavDestination) -> NavigationTransition {
        switch destination {
        case .initial:
            return .setSingleViewController(ViewController(router: unownedRouter))
        case .level1:
            return .push(VCLevel1(router: unownedRouter))
        case .level2:
            return .push(VCLevel2(router: unownedRouter))
        case .present1:
            return .present(
                Presented1VC(router: unownedRouter),
                presentationStyle: .overCurrentContext
            )
        case .present2:
            return .present(
                Presented2VC(router: unownedRouter),
                presentationStyle: .formSheet
            )
        case .compositePush:
            dismissAll(animated: true)
            return .push(CompositePushed(router: unownedRouter))
        case .subcoordinator:
            let subcoordinator = DetachedCoordinator
                .withContainerController(
                    with: ["shouldConfigureNavBar": true]
                )
            return .present(
                subcoordinator.rootViewController,
                presentationStyle: .overFullScreen,
                animated: false) {
                    subcoordinator.navigateTo(.subcoordinating)
                }
        }
    }
    
}
