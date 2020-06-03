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
        if username == "" || password == "" {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack(spacing: bigSpacing) {
            //top image of mentorship logo
            Image(mentorshipLogoImageName)
                .resizable()
                .scaledToFit()
            
            //username and password text fields
            VStack(spacing: smallSpacing) {
                CustomTextField(placeholder: "Username/Email", text: $username)
                CustomSecureField(placeholder: "Password", text: $password)
            }
            
            //login button
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Login")
            }
            .buttonStyle(BigBoldButtonStyle(disabled: loginDisabled))
            .disabled(loginDisabled)
            
            //text and sign up button
            VStack(spacing: minimalSpacing) {
                Text("Don't have an account?")
                
                Button.init(action: { self.showSignUpPage.toggle() }) {
                    Text("Signup")
                        .foregroundColor(defaultIndigoColor)
                }.sheet(isPresented: $showSignUpPage) {
                    SignUpView.init()
                }
            }
            
            //spacer to push content to top
            Spacer()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
