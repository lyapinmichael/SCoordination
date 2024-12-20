//
//  NavigationType.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 30.04.2024.
//

import UIKit

public enum NavigationType {
    case modal(presentationStyle: UIModalPresentationStyle, completion: (() -> Void)?)
    case pushing
    case setting
}
