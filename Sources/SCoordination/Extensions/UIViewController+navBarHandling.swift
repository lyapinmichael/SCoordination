//
//  UIViewController+prefersNavigationBarHidden.swift
//  MobileApp
//
//  Created by Михаил Ляпин on 28.04.2026.
//  Copyright © 2026 NPF Dinamika OOO. All rights reserved.
//

import UIKit
import ObjectiveC

private var prefersNavBarHiddenKey: UInt8 = 2

public extension UIViewController {
    
    var shouldHideNavigationBar: Bool {
        get {
            objc_getAssociatedObject(
                self,
                &prefersNavBarHiddenKey
            ) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(
                self,
                &prefersNavBarHiddenKey,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    @discardableResult
    func withNavigationBarHidden(_ hidden: Bool) -> Self {
        self.shouldHideNavigationBar = hidden
        return self
    }
}
