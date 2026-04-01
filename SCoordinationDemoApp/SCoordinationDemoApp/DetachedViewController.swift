//
//  DetachedViewController.swift
//  SCoordinationDemoApp
//
//  Created by Ляпин Михаил on 01.04.2026.
//

internal import UIKit
import SCoordination

final class DetachedViewController: UIViewController {
    
    private var router: UnownedRouter<DetachedDestination>
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
          button1,
        ])
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var button1: UIButton = {
        let button = UIButton()
        button.setTitle("Perform detached transition to ViewController", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(router: UnownedRouter<DetachedDestination>) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemMint
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    private func button1Tapped() {
        router.performDetachedTransition(ExampleDetachedContext(reason: .moveToBaseTree))
    }
    
}
