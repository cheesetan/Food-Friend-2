//
//  Styles.swift
//  Food Friend
//
//  Created by Tristan on 08/06/2023.
//

import Foundation
import SwiftUI

// MARK: - ButtonStyles
struct AuthenticationButtonStyle: ButtonStyle {
    
    let SFSymbolString: String
    @State var buttonTapped = false
    @Binding var loadingIndicator: Bool
    @Binding var failedSignIn: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Image(systemName: loadingIndicator ? failedSignIn ? "xmark.circle" : "ellipsis" : SFSymbolString)
                .contentTransition(.symbolEffect(.replace.downUp))
                .symbolEffect(.variableColor.iterative.dimInactiveLayers.nonReversing, isActive: loadingIndicator == true && failedSignIn == false)
                .symbolEffect(.bounce, value: failedSignIn == true)
                .foregroundStyle(failedSignIn ? .red : .primary)
                .onChange(of: configuration.isPressed) { _, _ in
                    if loadingIndicator {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5000)) {
                            failedSignIn = true
                        }
                    }
                }
        }
        .font(.headline)
        .fontWeight(.heavy)
        .padding()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            if configuration.isPressed {
                Color(white: 1.0, opacity: 0.2)
                    .cornerRadius(16)
            }
        }
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
        .animation(.bouncy(duration: 0.2, extraBounce: 0.2), value: configuration.isPressed)
    }
}

struct AlternateLogInOptionButtonButtonStyle: ButtonStyle {
    
    let SFSymbolString: String
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: SFSymbolString)
            configuration.label
        }
        .font(.headline)
        .fontWeight(.heavy)
        .padding()
        .foregroundStyle(.primary)
        .frame(maxWidth: .infinity)
        .background(.offBWForeground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            if configuration.isPressed {
                Color(white: 1.0, opacity: 0.2)
                    .cornerRadius(16)
            }
        }
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
        .animation(.bouncy(duration: 0.2, extraBounce: 0.2), value: configuration.isPressed)
    }
}

struct DefaultButtonButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .fontWeight(.heavy)
            .padding()
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - TextFieldStyles
struct AuthenticatonTextFieldStyle: TextFieldStyle {
    
    let SFSymbolString: String
    @FocusState var focused
    @State var focusedState = false
    @Environment(\.colorScheme) var colorScheme
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack(alignment: .center) {
            Image(systemName: SFSymbolString)
                .font(.title3)
                .offset(y: -3)
                .frame(width: 32)
            
            VStack(alignment: .leading) {
                configuration
                Divider()
                    .foregroundStyle(focusedState ? .primary : .secondary)
            }
        }
        .padding(.vertical, 20)
        .focused($focused)
        .onChange(of: focused) { _, _ in
            withAnimation {
                focusedState = focused
            }
        }
    }
}

struct DefaultTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading) {
            configuration
                .padding()
                .background(.ultraThickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding(.vertical, 5)
    }
}
