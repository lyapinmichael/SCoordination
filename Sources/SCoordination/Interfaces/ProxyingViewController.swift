//
//  ProxyingViewController.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 14.05.2024.
//

import UIKit

public protocol ProxyingViewController: UIViewController {
    func switchCurrent(to newViewController: UIViewController, withOptions options: UIView.AnimationOptions?)    
}
