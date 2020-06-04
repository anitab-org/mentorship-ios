//
//  LoginView.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 01/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var showSignUpPage: Bool = false
    @State private var username: String = ""
    @State private var password: String = ""
    
    var loginDisabled: Bool {
        if username.isEmpty || password.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack(spacing: DesignConstants.Spacing.bigSpacing) {
            //top image of mentorship logo
            Image(ImageNames.mentorshipLogoImageName)
                .resizable()
                .scaledToFit()
            
            //username and password text fields
            VStack(spacing: DesignConstants.Spacing.smallSpacing) {
                TextField("Username/Email", text: $username)
                    .textFieldStyle(RoundFilledTextFieldStyle())
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundFilledTextFieldStyle())
            }
            
            //login button
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Login")
            }
            .buttonStyle(BigBoldButtonStyle(disabled: loginDisabled))
            .disabled(loginDisabled)
            
            //text and sign up button
            VStack(spacing: DesignConstants.Spacing.minimalSpacing) {
                Text("Don't have an account?")
                
                Button.init(action: { self.showSignUpPage.toggle() }) {
                    Text("Signup")
                        .foregroundColor(DesignConstants.Colors.defaultIndigoColor)
                }.sheet(isPresented: $showSignUpPage) {
                    SignUpView.init()
                }
            }
            
            //spacer to push content to top
            Spacer()
        }
        .padding(.top, DesignConstants.Padding.topPadding)
        .padding(.bottom, DesignConstants.Padding.bottomPadding)
        .padding(.leading, DesignConstants.Padding.leadingPadding)
        .padding(.trailing, DesignConstants.Padding.trailingPadding)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
