//
//  LoginController.swift
//  TwitterClone
//
//  Created by Dario Gallegos on 06/09/2020.
//  Copyright © 2020 Dario Gallegos. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    private let logoImageVew: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "TwitterLogo")
        return imageView
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
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
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = Utilities().attributedButton(firstPart: "Don´t have an account?", secondPart: " Sign up")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleLogin() {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        
        AuthService.share().logUserIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("DEBUG: Error loging in \(error.localizedDescription)")
            }
            
            guard let window = UIApplication.shared.keyWindowInConnectedScenes else { return }
            guard let tab = window.rootViewController as? MainTabController else { return }
            tab.authenticationUserAndConfiguration()

            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(logoImageVew)
        logoImageVew.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageVew.setDimensions(width: 150, height: 150)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: logoImageVew.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor,paddingLeft: 16, paddingRight: 16)
    
        view.addSubview(signUpButton)
        signUpButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.rightAnchor, paddingLeft: 40, paddingBottom: 16, paddingRight: 40)
    }
    
}


extension UIApplication {

    /// The app's key window taking into consideration apps that support multiple scenes.
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }

}
