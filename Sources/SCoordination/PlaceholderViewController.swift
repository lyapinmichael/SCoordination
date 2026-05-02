//
//  PlaceholderViewController.swift
//  SCoordination
//
//  Created by Михаил Ляпин on 02.05.2026.
//

import UIKit

final class PlaceholderViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        shouldHideNavigationBar = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}
