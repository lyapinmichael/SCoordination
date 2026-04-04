//
//  Untitled.swift
//  SCoordinationDemoApp
//
//  Created by Ляпин Михаил on 04.04.2026.
//

internal import UIKit
import SCoordination

struct ExampleSimpleSelfPerformingContext: SelfPerformingDetachedContext {
    
    var performer: any ViewControlling
    
    func performDetachedTransition() {
        let alert = UIAlertController(
            title: "Hello there",
            message: "General Kenobi",
            preferredStyle: .alert
        )
        let closeAction = UIAlertAction(title: "Who is Roger?", style: .cancel)
        alert.addAction(closeAction)
        performer.rootViewController.present(alert, animated: true)
    }
    
}
