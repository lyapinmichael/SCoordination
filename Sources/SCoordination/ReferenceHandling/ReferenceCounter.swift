//
//  ReferenceCounter.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 30.04.2024.
//

import Foundation

public final class ReferenceCounter {
    var listener: ReferenceCounterListening?
    
    private var count: Int = 0 {
        didSet {
            guard count >= 0 else {
                assertionFailure("Reference count reached value below zero. Instace should have been terminated at this point.")
                return
            }
            if count == 0 {
                listener?.onCountDidReachZero()
                listener = nil
            }
        }
    }
}

extension ReferenceCounter: ReferenceOperatable {
    public static postfix func ++ (refCounter: ReferenceCounter) {
        refCounter.count += 1
    }
    
    public static postfix func -- (refCounter: ReferenceCounter) {
        refCounter.count -= 1
    }
}
