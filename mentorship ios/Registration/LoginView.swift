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
    
    var body: some View {
        VStack(spacing: bigSpacing) {
            Image(mentorshipLogoImageName)
                .resizable()
                .scaledToFill()
            
            VStack(spacing: smallSpacing) {
                CustomTextField(placeholder: "Username/Email", fieldValue: $username)
                CustomSecureField(placeholder: "Password", fieldValue: $password)
            }
            
            VStack(spacing: minimalSpacing) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    BigBoldButtonView(buttonText: "Login")
                }
                
                Text("Don't have an account?")
                
                Button.init(action: { self.showSignUpPage.toggle() }) {
                    Text("Signup")
                        .foregroundColor(defaultIndigoColor)
                }.sheet(isPresented: $showSignUpPage) {
                    SignUpView.init()
                }
            }
            
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
