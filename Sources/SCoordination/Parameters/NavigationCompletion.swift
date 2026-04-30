//
//  NavigationCompletion.swift
//  SCoordination
//
//  Created by Михаил Ляпин on 30.04.2026.
//

public enum NavigationCompletion {
    case shouldClearViewHeirarchy
    case shouldPopLastViewController(animated: Bool)
    case shouldDismiss(
        animated: Bool = true,
        completion: () -> Void = {}
    )
    case doNothing
}
