//
//  ViewController.swift
//  Real-Chat
//
//  Created by Dinesh Danda on 7/2/20.
//  Copyright © 2020 Dinesh Danda. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundWhite
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: AppLocalizedStrings.logout, style: .plain, target: self, action: #selector(didTapOnLogoutBtn))
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(didTapOnLogoutBtn), with: nil, afterDelay: 0)
        }
    }
    
    @objc func didTapOnLogoutBtn() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError.localizedDescription)
        }
        let loginVc = LoginViewController()
        loginVc.modalPresentationStyle = .fullScreen
        present(loginVc, animated: true, completion: nil)
    }

}

