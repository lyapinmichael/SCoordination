//
//  ViewCoordinating.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 07.05.2024.
//

import UIKit

// MARK: - ViewControlling

public protocol ViewControlling {
    associatedtype RootViewController: UIViewController
    var rootViewController: RootViewController { get }
}

// MARK: - AnyCoordinating

public typealias AnyCoordinator = Coordinating & ViewControlling
