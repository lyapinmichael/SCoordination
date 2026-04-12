//
//  CompositePushed.swift
//  SCoordinationDemoApp
//
//  Created by Ляпин Михаил on 12.04.2026.
//

internal import UIKit
import SCoordination

final class CompositePushed: UIViewController {
    
    private var router: UnownedRouter<DemoNavDestination>
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
          messageLabel,
        ])
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "This view controller was pushed after others were dismissed"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        view.backgroundColor = .systemYellow
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32)
        ])
    }
 
}
