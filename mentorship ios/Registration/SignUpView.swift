//
//  SignUpView.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 01/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var availabilityPickerSelection: Int = 2
    @State private var haveAcceptedTerms: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var signupDisabled: Bool {
        if name == "" || username == "" || email == "" || password != confirmPassword || !haveAcceptedTerms {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: bigSpacing) {
                    
                    //input fields for name, email, password, etc.
                    VStack(spacing: smallSpacing) {
                        CustomTextField(placeholder: "Name", text: $name)
                        CustomTextField(placeholder: "Username", text: $username)
                        CustomTextField(placeholder: "Email", text: $email)
                        CustomSecureField(placeholder: "Password", text: $password)
                        CustomSecureField(placeholder: "Confirm Password", text: $confirmPassword)
                    }
                    
                    //select availability as mentor, mentee, or both
                    VStack {
                        Text("Available to be a:").font(.headline)
                        
                        Picker(selection: $availabilityPickerSelection, label: Text("")) {
                            Text("Mentor").tag(1)
                            Text("Mentee").tag(2)
                            Text("Both").tag(3)
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    //sign up button
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Text("Sign Up")
                    }
                    .buttonStyle(BigBoldButtonStyle(disabled: signupDisabled))
                    .disabled(signupDisabled)
                    
                    //consent view, to accept terms and conditions
                    HStack {
                        Toggle(isOn: $haveAcceptedTerms) {
                            Text("I confirm that I have read and accept to be bound by the AnitaB.org Code of Conduct, Terms, and Privacy Policy. Further, I consent to the use of my information for the stated purpose.")
                                .font(.caption)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    
                    //spacer to push content to top and have bottom space for scroll view
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle("Sign Up")
            .navigationBarItems(leading:
                Button.init(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "x.circle.fill")
                        .font(.headline)
                        .accentColor(.secondary)
                })
            )
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
