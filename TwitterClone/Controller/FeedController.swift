//
//  FeedController.swift
//  TwitterClone
//
//  Created by Dario Gallegos on 04/09/2020.
//  Copyright © 2020 Dario Gallegos. All rights reserved.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
        
    //MARK: - Properties
    
    private let titleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "twitter_logo_blue")
        imageView.setDimensions(width: 44, height: 44)
        return imageView
    }()
    
    var user: User? {
        didSet {
            print("DEBUG: Did set user in feed controller ...")
            configureLeftBarButton()
        }
    }
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }

    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.titleView = titleImage
    }
    
    func configureLeftBarButton() {
        
        guard let user = user else { return }
        
        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.sd_setImage(with: user.profileImageURL, completed: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
}
