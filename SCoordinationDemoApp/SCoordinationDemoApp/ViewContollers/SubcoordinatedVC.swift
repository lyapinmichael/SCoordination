//
//  SubcoordinatedVC.swift
//  SCoordinationDemoApp
//
//  Created by Михаил Ляпин on 01.05.2026.
//

internal import UIKit
import SCoordination

final class SubcoordinatedVC: UIViewController {
    
    private var router: UnownedRouter<DetachedDestination>
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(router: UnownedRouter<DetachedDestination>) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = "Subcoordinated view controller"
        view.backgroundColor = .systemPink
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32)
        ])
    }
    
}
