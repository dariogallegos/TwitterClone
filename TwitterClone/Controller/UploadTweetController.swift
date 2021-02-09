//
//  UploadTweetController.swift
//  TwitterClone
//
//  Created by Dario Gallegos on 6/2/21.
//  Copyright © 2021 Dario Gallegos. All rights reserved.
//

import Foundation
import UIKit

class UploadTweetController: UIViewController {
    
    //MARK: - Properties
    private let user: User
    
    
    private lazy var tweetButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect (x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32/2
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(handleTweet), for: .touchUpInside)
        return button
        
    }()
    
    private let profileImageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 48/2
        image.setDimensions(width: 48, height: 48)
        image.backgroundColor = .red
        return image
    }()
    
    private let captionTextView = CaptionTextView()
    
    
    //MARK: - Lifecycle
    init(user:User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

    }
    
    //MARK: - Selectors
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTweet() {
        print("DEBUG: Tweet")
    }
    
    //MARK: - API
    
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        //La imagen se queda cacheada por lo que el sd_setImage no vuelve a descargarla de una url, la pilla de la cache
        profileImageView.sd_setImage(with: user.profileImageURL, completed: nil)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
    }
    
}
