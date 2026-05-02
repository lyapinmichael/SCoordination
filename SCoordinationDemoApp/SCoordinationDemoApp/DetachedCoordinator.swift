//
//  DetachedCoordinator.swift
//  SCoordinationDemoApp
//
//  Created by Ляпин Михаил on 01.04.2026.
//

internal import UIKit
import SCoordination

enum DetachedDestination: Destination {
    case initial
    case subcoordinating
}

final class DetachedCoordinator: NavigationCoordinator<DetachedDestination> {
    
    override func prepareNavigationTransition(for destination: DetachedDestination) -> NavigationTransition {
        switch destination {
        case .initial:
            return .setSingleViewController(DetachedViewController(router: unownedRouter))
        case .subcoordinating:
            return .push(SubcoordinatedVC(router: unownedRouter))
        }
    }
    
    override func prepareToStart(with preconditionData: [String : Any]) {
        if
            let flag = preconditionData["shouldConfigureNavBar"] as? Bool,
            flag == true
        {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .magenta
            rootViewController.navigationBar.standardAppearance = appearance
            rootViewController.navigationBar.scrollEdgeAppearance = appearance
            rootViewController.navigationBar.compactAppearance = appearance
            rootViewController.navigationBar.prefersLargeTitles = false
        }
    }
    
    deinit {
        print("\(Self.self) called to deinit")
    }
    
}
