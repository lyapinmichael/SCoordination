//
//  PlaceholderViewController.swift
//  SCoordination
//
//  Created by Михаил Ляпин on 02.05.2026.
//

import UIKit

final class PlaceholderViewController: UIViewController {
    
    init(rootBackButtonParameters: BackButtonParameters = .systemDefault) {
        super.init(nibName: nil, bundle: nil)
        shouldHideNavigationBar = true
        modalPresentationStyle = .overFullScreen
        if case .custom(let title, let tintColor) = rootBackButtonParameters {
            self.navigationItem.backBarButtonItem = .init(
                title: title,
                style: .plain,
                target: nil,
                action: nil
            )
            self.navigationItem.backBarButtonItem?.tintColor = tintColor
            self.navigationItem.backBarButtonItem?.title = title
            self.navigationItem.backBarButtonItem?.menu = nil
        }
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
