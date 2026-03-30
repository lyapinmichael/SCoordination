//
//  ViewController.swift
//  SCoordinationDemoApp
//
//  Created by Ляпин Михаил on 30.03.2026.
//

internal import UIKit
import SCoordination

class ViewController: UIViewController {
    
    private var router: UnownedRouter<DemoNavDestination>
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
          messageLabel,
          button1,
        ])
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Root in navigation heirarchy"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button1: UIButton = {
        let button = UIButton()
        button.setTitle("Go to Level 1", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(router: UnownedRouter<DemoNavDestination>) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    private func button1Tapped() {
        router.navigateTo(.level1)
    }

}

