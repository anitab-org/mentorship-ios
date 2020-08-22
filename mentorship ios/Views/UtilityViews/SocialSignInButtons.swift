//
//  SocialSignInButtons.swift
//  Created on 14/08/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI
import GoogleSignIn
import AuthenticationServices

// Google
struct GoogleSignInButton: UIViewRepresentable {
    func makeUIView(context: Context) -> GIDSignInButton {
        return GIDSignInButton()
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {
    }
}

// Apple
struct AppleSignInButton: UIViewRepresentable {
    let dark: Bool
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .default, style: dark ? .black : .white)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}
