//
//  Destination.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 09.05.2024.
//

import Foundation

/// This protocol has no requirements althogh it is encouraged to be implemented
/// by an enum, that contains all possible destinatinos for navigation from
///  NavigationCoordinator.
public protocol Destination {
    static var initial: Self { get }
}

extension Destination {
    public func pop() {}
    public func popToRoot() {}
}
