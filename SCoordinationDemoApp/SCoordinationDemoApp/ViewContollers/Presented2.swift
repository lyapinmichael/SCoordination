//
//  Presented1.swift
//  SCoordinationDemoApp
//
//  Created by Ляпин Михаил on 12.04.2026.
//

internal import UIKit
import SCoordination

final class Presented2VC: UIViewController {
    
    private var router: UnownedRouter<DemoNavDestination>
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
          messageLabel,
          button1,
          button2,
          button3,
          button4
        ])
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Demonstration of modal presentation hierarchy"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button1: UIButton = {
        let button = UIButton(configuration: .gray())
        button.setTitle("Dismiss this one", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var button2: UIButton = {
        let button = UIButton(configuration: .gray())
        button.setTitle("Dismiss all", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var button3: UIButton = {
        let button = UIButton(configuration: .gray())
        button.setTitle("Dismiss all and push to other", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.addTarget(self, action: #selector(button3Tapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var button4: UIButton = {
        let button = UIButton(configuration: .gray())
        button.setTitle("Start subcoodinator", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.addTarget(self, action: #selector(button4Tapped), for: .touchUpInside)
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
        view.backgroundColor = .systemGray5
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    private func button1Tapped() {
        router.dismiss()
    }
    
    @objc
    private func button2Tapped() {
        router.dismissAll()
    }
    
    @objc
    private func button3Tapped() {
        router.navigateTo(.compositePush)
    }
    
    @objc
    private func button4Tapped() {
        router.navigateTo(.subcoordinator)
    }
}
