//
//  UserService.swift
//  TwitterClone
//
//  Created by Dario Gallegos on 2/2/21.
//  Copyright © 2021 Dario Gallegos. All rights reserved.
//

import Firebase

struct UserService {
    
    //MARK: - Properties
    
    private static var sharedUserService:UserService = {
        let userService = UserService()
        //Additional configuration ..
        
        return userService
    }()
    
    
    //MARK: - Accessors
    
    static func share() -> UserService {
        return sharedUserService
    }
    
    //MARK: - Methods
    
    func fetchUser(completion: @escaping(User) -> Void) {
        
        guard let userID = AUTH_REF.currentUser?.uid else { return }
        REF_USERS.child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            guard let dictionary = snapshot.value as? [String: AnyObject] else {
                print("DEBUG: Error al pasear el data snapshot")
                return
            }
            
            let user = User(uid: userID, dictionary: dictionary)
            print("DEBUG: usuario recuperado \(user)")
            completion(user)

          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
