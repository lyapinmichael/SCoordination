//
//  ProxyViewController.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 10.05.2024.
//

import UIKit

public final class ProxyViewController: UIViewController {
    // MARK: Private properties
    
    private var currentViewController: UIViewController? {
        children.last
    }
    
    // MARK: Init
    
    public convenience init() {
        self.init(currentViewController: UIViewController())
    }
    
    public init(currentViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        addChild(currentViewController)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   // MARK: Lifecycle
    
    public override func viewDidLoad() {
            super.viewDidLoad()
            
        guard let currentViewController else { return }
        currentViewController.view.frame = view.bounds
        view.addSubview(currentViewController.view)
        currentViewController.didMove(toParent: self)
        }
}

extension ProxyViewController {
    private func add(
        _ child: UIViewController,
        completion: @escaping () -> Void = {}
    ) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        completion()
    }

    private func removeChild(_ childViewController: UIViewController) {
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }
}

// MARK: - ProxyingViewController

extension ProxyViewController: ProxyingViewController {    
    public final func switchCurrent(to newViewController: UIViewController, withOptions: UIView.AnimationOptions? = nil) {
        add(newViewController)
        if self.children.count > 2 {
            removeChild(self.children[children.count - 2])
        }
    }
}
