//
//  SettingsView.swift
//  Food Friend
//
//  Created by Tristan on 07/06/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject private var AuthVM = AuthenticationViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Text("Settings View")
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    SignOutButton
                }
            }
        }
    }
    
    var SignOutButton: some View {
        Button(role: .destructive) {
            AuthVM.signOut()
        } label: {
            Text("Sign Out")
        }
    }
}

#Preview {
    SettingsView()
}
