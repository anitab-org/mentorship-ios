//
//  LoginView.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 01/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(spacing: 50) {
            Image("mentorship_system_logo")
                .resizable()
                .scaledToFit()
                .frame(alignment: Alignment.top)
            
            VStack(spacing: 20) {
                TextField("Username/Email", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: /*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Value@*/.constant("Apple")/*@END_MENU_TOKEN@*/)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(spacing: 20) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Login")
                        .padding([.vertical], 8)
                        .padding([.horizontal], 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Button.init(action: {}) {
                    Text("Signup")
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
