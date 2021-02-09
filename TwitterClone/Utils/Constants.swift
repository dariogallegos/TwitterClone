//
//  Constants.swift
//  TwitterClone
//
//  Created by Dario Gallegos on 31/1/21.
//  Copyright © 2021 Dario Gallegos. All rights reserved.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let BD_REF = Database.database().reference()
let REF_USERS = BD_REF.child("users")

let AUTH_REF = Auth.auth()
