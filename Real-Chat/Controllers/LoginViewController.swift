//
//  LoginViewController.swift
//  Real-Chat
//
//  Created by Dinesh Danda on 7/2/20.
//  Copyright © 2020 Dinesh Danda. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    var inputContainerHeightConstraint: NSLayoutConstraint?
    var nameTextFieldHeightConstraint: NSLayoutConstraint?
    var emailTextFieldHeightConstraint: NSLayoutConstraint?
    var passwordTextFieldHeightConstraint: NSLayoutConstraint?

    
    let inputContainerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .backgroundWhite
        containerView.layer.cornerRadius = 5.0
        containerView.clipsToBounds = true
        containerView.layer.borderWidth = 2.0
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        return containerView
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(AppLocalizedStrings.register, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.loginBlue
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    let choiceSegmentedController: UISegmentedControl = {
        let choiceSegmentArray = ["Login","Register"]
        let segmentController = UISegmentedControl(items: choiceSegmentArray)
        segmentController.translatesAutoresizingMaskIntoConstraints = false
        segmentController.backgroundColor = UIColor.clear
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentController.selectedSegmentTintColor = UIColor.darkGray
        segmentController.selectedSegmentIndex = 1
        segmentController.layer.cornerRadius = 5.0
        segmentController.clipsToBounds = true
        segmentController.addTarget(self, action: #selector(handleChoiceSelection), for: .valueChanged)
        return segmentController
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = AppLocalizedStrings.name
        tf.backgroundColor = UIColor.clear
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = AppLocalizedStrings.email
        tf.backgroundColor = UIColor.clear
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = AppLocalizedStrings.password
        tf.backgroundColor = UIColor.clear
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeperaterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    } ()
    
    let emailSeperaterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    } ()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle.fill")
        return imageView
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.logInBGC
        view.addSubview(inputContainerView)
        view.addSubview(registerButton)
        view.addSubview(choiceSegmentedController)
        view.addSubview(profileImage)
        setupConstaints()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc fileprivate func handleChoiceSelection(sender: UISegmentedControl) {
        if let title = choiceSegmentedController.titleForSegment(at: choiceSegmentedController.selectedSegmentIndex) {
            registerButton.setTitle(title, for: .normal)
        } else {
            print(Error.self)
        }
        inputContainerHeightConstraint?.constant = choiceSegmentedController.selectedSegmentIndex == 0 ? 130 : 200
        nameTextFieldHeightConstraint?.isActive = false
        nameTextFieldHeightConstraint = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: choiceSegmentedController.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightConstraint?.isActive = true
        emailTextFieldHeightConstraint?.isActive = false
        emailTextFieldHeightConstraint = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: choiceSegmentedController.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightConstraint?.isActive = true
        passwordTextFieldHeightConstraint?.isActive = false
        passwordTextFieldHeightConstraint = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: choiceSegmentedController.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightConstraint?.isActive = true
    }
    
    @objc func handleLoginRegister() {
        if choiceSegmentedController.selectedSegmentIndex == 0 {
            didPressLogInButton()
        } else {
            didPressRegisterButton()
        }
    }
    
    func didPressLogInButton() {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let signInError = error {
                    print(signInError.localizedDescription)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

    func didPressRegisterButton() {
        if let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    print(AppLocalizedStrings.registerSuccess)
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    let ref = Database.database().reference(fromURL: URLConstants.refdbUrl)
                    let usersRef = ref.child(AppLocalizedStrings.users).child(userID)
                    let values = [AppLocalizedStrings.name: name, AppLocalizedStrings.email: email]
                    usersRef.updateChildValues(values) { (error, ref) in
                        if let storeError = error {
                            print(storeError.localizedDescription)
                        } else {
                            self.dismiss(animated: true, completion: nil)
                            print(AppLocalizedStrings.registerSaved)
                        }
                    }
                    
                }
            }
            
        }
    }
    
    func setupConstaints() {
        
        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(passwordTextField)
        inputContainerView.addSubview(nameSeperaterView)
        inputContainerView.addSubview(emailSeperaterView)
        
        profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: choiceSegmentedController.topAnchor, constant: -60).isActive = true
        
        choiceSegmentedController.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        choiceSegmentedController.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -20).isActive = true
        choiceSegmentedController.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -24).isActive = true
        choiceSegmentedController.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -24).isActive = true
        inputContainerHeightConstraint = inputContainerView.heightAnchor.constraint(equalToConstant: 200)
        inputContainerHeightConstraint?.isActive = true
        
        nameTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 12).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, constant: 0).isActive = true
        nameTextFieldHeightConstraint = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightConstraint?.isActive = true
        
        nameSeperaterView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameSeperaterView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        nameSeperaterView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,constant: 1).isActive = true
        
        emailTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 12).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, constant: 0).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameSeperaterView.bottomAnchor).isActive = true
        emailTextFieldHeightConstraint = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightConstraint?.isActive = true

        emailSeperaterView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailSeperaterView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeperaterView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        passwordTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 12).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, constant: 0).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextFieldHeightConstraint = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightConstraint?.isActive = true

        
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -24).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}
