//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Dario Gallegos on 04/09/2020.
//  Copyright © 2020 Dario Gallegos. All rights reserved.
//

import UIKit
import Firebase
 
class MainTabController: UITabBarController {
    
    //MARK: - Properties
    var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            
            feed.user = user
        }
    }
    
    
    private let actionButton: UIButton = {
        let button = UIButton (type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //logUserOut()
        view.backgroundColor = .twitterBlue
        authenticationUserAndConfiguration()
        
    }
    
    //MARK: - API
    
    func fetchUser() {
        UserService.share().fetchUser { user in
            self.user = user
        }
    }
    
    func authenticationUserAndConfiguration(){
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
        else {
            configurationViewControllers()
            configureUI()
            fetchUser()
        }
    }
    
    func logUserOut() {
        do {
            try AUTH_REF.signOut()
        } catch let error {
            print ("Error signing out: %@", error.localizedDescription)
        }
    }
    
    
    //MARK: - Selectors
    
    @objc func actionButtonTapped(){
        guard let user = user else { return }
        let nav = UINavigationController(rootViewController: UploadTweetController(user: user))
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true,completion: nil)
    }
    
    
    //MARK: - Helpers
    
    func configureUI(){
        view.addSubview(actionButton)
        actionButton .anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56/2
    }
    
    func configurationViewControllers() {
        
        let feed = FeedController()
        let navFeed = templeNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        
        let explore = ExploreController()
        let navExplore = templeNavigationController(image: UIImage(named: "search_unselected"), rootViewController: explore)
        
        let notifications = NotificationsController()
        let navNotifications = templeNavigationController(image: UIImage(named: "like_unselected"), rootViewController: notifications)
        
        let conversations = ConversationsController()
        let navConversations =  templeNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversations)
        
        //create a tabBar with the controllers
        viewControllers = [navFeed, navExplore, navNotifications, navConversations]
    }
    
    
    func templeNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }

}
