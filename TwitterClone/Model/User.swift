//
//  User.swift
//  TwitterClone
//
//  Created by Dario Gallegos on 3/2/21.
//  Copyright © 2021 Dario Gallegos. All rights reserved.
//

import Foundation

struct User {
    
    let email: String
    let fullname: String
    let username: String
    var profileImageURL: URL?
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        
        if let profileImageString = dictionary["profileImage"] as? String {
            guard let url = URL(string: profileImageString) else { return }
            self.profileImageURL = url
        }
    }
}
