//
//  SignInView.swift
//  Food Friend
//
//  Created by Tristan on 08/06/2023.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email = String()
    @State private var password = String()
    
    @ObservedObject private var AuthVM = AuthenticationViewModel()

    var body: some View {
        VStack {
            TextField("Email", text: $email)
            TextField("Password", text: $password)
            
            Button {
                AuthVM.signIn(email: email, password: password)
            } label: {
                Text("sign in")
            }
        }
    }
}

#Preview {
    SignInView()
}
