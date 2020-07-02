//
//  LoginViewController.swift
//  Real-Chat
//
//  Created by Dinesh Danda on 7/2/20.
//  Copyright © 2020 Dinesh Danda. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
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
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(AppLocalizedStrings.register, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.loginBlue
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        return button
    }()
    
    let choiceSegmentedController: UISegmentedControl = {
        let choiceSegmentArray = ["Login","Register"]
        let segmentController = UISegmentedControl(items: choiceSegmentArray)
        segmentController.translatesAutoresizingMaskIntoConstraints = false
        segmentController.backgroundColor = UIColor.clear
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentController.selectedSegmentTintColor = UIColor.darkGray
        segmentController.selectedSegmentIndex = 0
        segmentController.layer.cornerRadius = 5.0
        segmentController.clipsToBounds = true
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
        inputContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        nameTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 12).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, constant: 0).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        nameSeperaterView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameSeperaterView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        nameSeperaterView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,constant: 1).isActive = true
        
        emailTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 12).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, constant: 0).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameSeperaterView.bottomAnchor).isActive = true
        
        emailSeperaterView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailSeperaterView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeperaterView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        passwordTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 12).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, constant: 0).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -24).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}
