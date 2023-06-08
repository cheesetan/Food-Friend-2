//
//  AuthenticationView.swift
//  Food Friend
//
//  Created by Tristan on 09/06/2023.
//

import SwiftUI

struct AuthenticationView: View {
    
    @AppStorage("showingSignInView", store: .standard) var showingSignInView = false
    
    var body: some View {
        if showingSignInView {
            SignInView(showingSignInView: $showingSignInView)
        } else {
            SignUpView(showingSignInView: $showingSignInView)
        }
    }
}

#Preview {
    AuthenticationView()
}
