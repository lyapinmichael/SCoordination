//
//  Coordinating.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 30.04.2024.
//

import Foundation

public protocol Coordinating: ReferenceCounting {
    /// Incapsulates what exactly should happen (e.g. what should the initial
    /// screen for the coordinated flow be) at the moment of statring this coordinator.
    func start()
    
    /// Handles events that should occur when coordinator is either
    /// no longer needed or is forced to stop by input
    func stop()
    
    /// Adds child coordinator to the correspoding aray. If `shouldStartImmediately` is `true` it
    /// calls `start()` method of child coordinator just as it was added to parent.
    func addChild(_ childCoordinator: some Coordinating, shouldStartImmediately: Bool)
    
    /// Removes child coordinator from the correspoding aray.
    func removeChild(_ childCoordinator: some Coordinating)
}
