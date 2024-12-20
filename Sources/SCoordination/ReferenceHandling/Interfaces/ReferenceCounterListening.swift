//
//  ReferenceCounterListening.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 30.04.2024.
//

import Foundation

public protocol ReferenceCounterListening: AnyObject {    
    /// Is called in a `delegate`-manner when references count reaches zero.
    func onCountDidReachZero()
}
