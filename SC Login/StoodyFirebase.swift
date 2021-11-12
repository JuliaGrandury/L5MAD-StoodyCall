//
//  StoodyFirebase.swift
//  SC Login
//
//  Created by Pranav Jain on 12/2/19.
//  Copyright © 2019 Michael Hofstadter. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class StoodyFirebase{
    static let db = Firestore.firestore()
    static let storage = Storage.storage()
    static var email = "";
    static var password = "";
    static var profileImage: UIImage?;
    static var currentUser = UserModel(name: "pass", year: "First Year", music: "Spotify Peaceful Piano playlist", vibe: "e", classes:[], matches: [], likes: [], phoneNumber: "1")
//    static var currentUser = MainUser(email: "John", password: "heya@gmail.com", name: "pass", year: "First Year", music: "Spotify Peaceful Piano playlist", vibe: 1, classes:[], matches: [], likes: []);
}
