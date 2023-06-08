//
//  SignUpView.swift
//  Food Friend
//
//  Created by Tristan on 09/06/2023.
//

import SwiftUI

struct SignUpView: View {
    @Binding var showingSignInView: Bool
    
    @State var loadingIndicator = false
    @State var failedSignIn = false
    
    @State private var email = String()
    @State private var password = String()
    @State private var confirmPassword = String()
    
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @FocusState var passwordFocus: Bool
    
    @ObservedObject private var AuthVM = AuthenticationViewModel()

    var body: some View {
        ZStack {
            Color.offBWBackground.ignoresSafeArea()
            VStack(alignment: .leading) {
                Spacer()
                
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(.bottom, 5)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(AuthenticatonTextFieldStyle(SFSymbolString: "envelope"))
                
                passwordField
                
                confirmPasswordField
                
                signUpButton
                
                Spacer()
                
                switchToSignUpViewButton
                    .padding(.bottom)
            }
            .padding(.horizontal, 30)
        }
        .scrollDismissesKeyboard(.interactively)
    }
    
    var passwordField: some View {
        VStack {
            if showPassword {
                HStack {
                    TextField("Password", text: $password)
                        .textFieldStyle(AuthenticatonTextFieldStyle(SFSymbolString: "rectangle.and.pencil.and.ellipsis"))
                    showPasswordButton
                }
            } else {
                HStack {
                    SecureField("Password", text: $password)
                        .textFieldStyle(AuthenticatonTextFieldStyle(SFSymbolString: "rectangle.and.pencil.and.ellipsis"))
                    showPasswordButton
                }
            }
        }
    }
    
    var confirmPasswordField: some View {
        VStack {
            if showPassword {
                HStack {
                    TextField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(AuthenticatonTextFieldStyle(SFSymbolString: "rectangle.and.pencil.and.ellipsis"))
                    showConfirmPasswordButton
                }
            } else {
                HStack {
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(AuthenticatonTextFieldStyle(SFSymbolString: "rectangle.and.pencil.and.ellipsis"))
                    showConfirmPasswordButton
                }
            }
        }
    }
    
    var showPasswordButton: some View {
        VStack {
            Button {
                withAnimation {
                    showPassword.toggle()
                }
            } label: {
                Image(systemName: showPassword ? "eye" : "eye.slash")
            }
            .foregroundStyle(.gray)
        }
    }
    
    var showConfirmPasswordButton: some View {
        VStack {
            Button {
                withAnimation {
                    showConfirmPassword.toggle()
                }
            } label: {
                Image(systemName: showPassword ? "eye" : "eye.slash")
            }
            .foregroundStyle(.gray)
        }
    }
    
    var switchToSignUpViewButton: some View {
        Button {
            withAnimation {
                showingSignInView.toggle()
            }
        } label: {
            Spacer()
            Text("Already have an account? \(Text("Login!").foregroundStyle(.blue).fontWeight(.bold))")
                .font(.headline)
                .fontWeight(.bold)
            Spacer()
        }
        .buttonStyle(.plain)
    }
    
    var signUpButton: some View {
        Button {
            loadingIndicator = true
            failedSignIn = false
            AuthVM.createNewAccount()
        } label: {
            Text("Create account and Login")
        }
        .buttonStyle(AuthenticationButtonStyle(SFSymbolString: "arrow.right", loadingIndicator: $loadingIndicator, failedSignIn: $failedSignIn))
        .buttonStyle(.plain)
    }
}

#Preview {
//    SignUpView()
}
