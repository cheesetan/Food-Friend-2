//
//  ContentView.swift
//  Food Friend
//
//  Created by Tristan on 07/06/2023.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    
    @AppStorage("signedIn", store: .standard) private var signedIn = false
    
    var body: some View {
        if signedIn {
            MainView()
        } else {
            AuthenticationView()
        }
    }
    
    func updateSignedInState() {
        if user == nil {
            signedIn = false
        } else {
            signedIn = true
        }
    }
}

#Preview {
    ContentView()
}
