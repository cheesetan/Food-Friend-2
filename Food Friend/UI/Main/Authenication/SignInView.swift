//
//  SignInView.swift
//  Food Friend
//
//  Created by Tristan on 08/06/2023.
//

import SwiftUI

struct SignInView: View {
    
    @Binding var showingSignInView: Bool
    
    @State var loadingIndicator = false
    @State var failedSignIn = false
    
    @State private var email = String()
    @State private var password = String()
    
    @State private var showPassword = false
    @FocusState var passwordFocus: Bool
    
    @ObservedObject private var AuthVM = AuthenticationViewModel()

    var body: some View {
        ZStack {
            Color.offBWBackground.ignoresSafeArea()
            VStack(alignment: .leading) {
                Spacer()
                
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(.bottom, 5)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(AuthenticatonTextFieldStyle(SFSymbolString: "envelope"))
                
                passwordField
                
                signInButton
                                
                alternateLogInOptionsDivider
                
                alternateLogInOptionButton(label: "Login with QR Code", SFSymbolString: "qrcode") {
                    print("amongus")
                }
                                
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
    
    var switchToSignUpViewButton: some View {
        Button {
            withAnimation {
                showingSignInView.toggle()
            }
        } label: {
            Spacer()
            Text("New to Food Friend? \(Text("Create an account!").foregroundStyle(.blue).fontWeight(.bold))")
                .font(.headline)
                .fontWeight(.bold)
            Spacer()
        }
        .buttonStyle(.plain)
    }
    
    var signInButton: some View {
        Button {
            loadingIndicator = true
            failedSignIn = false
            AuthVM.signIn(email: email, password: password)
        } label: {
            Text("Login")
        }
        .buttonStyle(AuthenticationButtonStyle(SFSymbolString: "arrow.right", loadingIndicator: $loadingIndicator, failedSignIn: $failedSignIn))
        .buttonStyle(.plain)
    }
    
    var alternateLogInOptionsDivider: some View {
        HStack {
            VStack {
                Divider()
            }
            Text("OR")
                .font(Font.system(.headline).uppercaseSmallCaps())
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
            VStack {
                Divider()
            }
        }
        .padding(.vertical)
    }
    
    func alternateLogInOptionButton(label: String, SFSymbolString: String, action: @escaping () -> Void) -> some View {
        VStack {
            Button {
                action()
            } label: {
                Text("\(label)")
            }
            .buttonStyle(AlternateLogInOptionButtonButtonStyle(SFSymbolString: SFSymbolString))
        }
    }
}

#Preview {
//    SignInView()
}
