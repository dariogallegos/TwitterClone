//
//  NotificationsController.swift
//  TwitterClone
//
//  Created by Dario Gallegos on 04/09/2020.
//  Copyright © 2020 Dario Gallegos. All rights reserved.
//

import UIKit

class NotificationsController: UIViewController {
        
    //MARK: - Properties
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    //MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
    }
}
