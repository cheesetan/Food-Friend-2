//
//  AuthenticationViewModel.swift
//  Food Friend
//
//  Created by Tristan on 08/06/2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

final class AuthenticationViewModel: ObservableObject {
    
    @AppStorage("signedIn", store: .standard) private var signedIn = false
    
    func createNewAccount() {
        
    }
    
    func signIn(email: String, password: String) {
        signInToAccount(email: email, password: password) { response in
            switch response {
                case .success(_):
                    self.signedIn = true
                case .failure(let error):
                    self.signedIn = false
                    print(error.localizedDescription)
            }
        }
    }
    
    func signOut() {
        signOutOfAccount { successfullySignedOut in
            switch successfullySignedOut {
                case true:
                    self.signedIn = false
                case false:
                    self.signedIn = true
            }
        }
    }
}
