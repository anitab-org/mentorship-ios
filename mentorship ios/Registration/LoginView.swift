//
//  LoginView.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 01/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var showSignUpPage = false
    
    var body: some View {
        VStack(spacing: bigSpacing) {
            Image(mentorshipLogoImageName)
                .resizable()
                .scaledToFill()
            
            VStack(spacing: smallSpacing) {
                TextField("Username/Email", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding(preferredPadding)
                    .background(
                        RoundedRectangle(cornerRadius: preferredCornerRadius)
                            .fill(secondaryBackground)
                )
                
                SecureField("Password", text: /*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Value@*/.constant("Apple")/*@END_MENU_TOKEN@*/)
                    .padding(preferredPadding)
                    .background(
                        RoundedRectangle(cornerRadius: preferredCornerRadius)
                            .fill(secondaryBackground)
                )
            }
            
            VStack(spacing: smallSpacing) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    BigBoldButtonView(buttonText: "Login")
                }
                
                Button.init(action: { self.showSignUpPage.toggle() }) {
                    Text("Signup")
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
