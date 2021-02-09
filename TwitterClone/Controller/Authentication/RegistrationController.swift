//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by Dario Gallegos on 06/09/2020.
//  Copyright © 2020 Dario Gallegos. All rights reserved.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        return view
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullnameTextField)
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: usernameTextField)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullnameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Full Name")
        return tf
    }()
    
    private let usernameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Username")
        return tf
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    private let showLoginButton: UIButton = {
        let button = Utilities().attributedButton(firstPart: "Already have an account?", secondPart: " Log in")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleRegistration() {
        
        guard let profileImage = self.profileImage else {
            print("DEBUG: please select a profile image")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        
        let credentials = AuthCredentials(email: email,
                                          password: password,
                                          fullname: fullname,
                                          username: username,
                                          profileImage: profileImage)
        
        AuthService.share().registerUser(credentials: credentials) { (error, ref) in
            if let error = error {
                print("DEBUG : Error registration \(error.localizedDescription)")
            }
            guard let window = UIApplication.shared.keyWindowInConnectedScenes else { return }
            guard let tab = window.rootViewController as? MainTabController else { return }
            tab.authenticationUserAndConfiguration()

            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 16)
        plusPhotoButton.setDimensions(width: 140, height: 140)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,fullnameContainerView,usernameContainerView,registrationButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        
        stack.anchor(top: plusPhotoButton.bottomAnchor,
                     left: view.safeAreaLayoutGuide.leftAnchor,
                     right: view.safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(showLoginButton)
        showLoginButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                               right: view.rightAnchor, paddingLeft: 40, paddingBottom: 16, paddingRight: 40)
    }
    
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let profileImage = info[.editedImage] as? UIImage else { return  }
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 140/2;
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds =  true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
        
    }
}
