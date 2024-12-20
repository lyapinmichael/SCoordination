//
//  DetachedContext.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 10.05.2024.
//

import Foundation

open class DetachedContext<ReasonType: Reason> {
    public var reason: ReasonType
    
    public init(reason: ReasonType) {
        self.reason = reason
    }
    
    open func performDetachedTransition() {
        return 
    }
}
