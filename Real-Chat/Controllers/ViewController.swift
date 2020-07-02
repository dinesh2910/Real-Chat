//
//  ViewController.swift
//  Real-Chat
//
//  Created by Dinesh Danda on 7/2/20.
//  Copyright © 2020 Dinesh Danda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundWhite
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: AppLocalizedStrings.logout, style: .plain, target: self, action: #selector(didTapOnLogoutBtn))
    }
    
    @objc func didTapOnLogoutBtn() {
        let loginVc = LoginViewController()
        loginVc.modalPresentationStyle = .fullScreen
        present(loginVc, animated: true, completion: nil)
    }

}

