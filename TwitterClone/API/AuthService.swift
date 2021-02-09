//
//  AuthService.swift
//  TwitterClone
//
//  Created by Dario Gallegos on 31/1/21.
//  Copyright © 2021 Dario Gallegos. All rights reserved.
//

import Foundation
import Firebase
import UIKit

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    
    //MARK: - Properties
    
    private static var sharedAuthService:AuthService = {
        let authService = AuthService()
        //Configuration ..
        
        return authService
    }()
    
    
    //MARK: - Accessors
    
    static func share() -> AuthService {
        return sharedAuthService
    }
    
    //MARK: - Methods
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        
        AUTH_REF.signIn(withEmail: email, password: password, completion: completion)
    }
    
    
    func registerUser(credentials: AuthCredentials, completion: @escaping (Error?, DatabaseReference) -> Void) {
        
        let email = credentials.email
        let password = credentials.password
        let fullname = credentials.fullname
        let username = credentials.username
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {return}
        
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            
            if let error = error {
                print("Error \(error.localizedDescription)")
                return
            }
            
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Error \(error.localizedDescription)")
                    return
                }
                guard let profileImageURL = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    
                    if let error = error {
                        print("Error \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = authResult?.user.uid else { return }
                    
                    let values = ["email": email,
                                  "username": username,
                                  "fullname": fullname,
                                  "profileImage": profileImageURL]
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}
