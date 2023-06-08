//
//  Variables.swift
//  Food Friend
//
//  Created by Tristan on 08/06/2023.
//

import Foundation
import Firebase
import FirebaseAuth

let user = Auth.auth().currentUser
let userUID = Auth.auth().currentUser?.uid
let userEmail = Auth.auth().currentUser?.email

