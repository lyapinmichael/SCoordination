//
//  UIViewController+topViewController.swift
//  SCoordination
//
//  Created by Ляпин Михаил on 12.04.2026.
//

import UIKit

extension UIViewController {
    
    var topmostViewContoller: UIViewController {
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topmostViewContoller
        } else {
            return self
        }
    }
    
}
