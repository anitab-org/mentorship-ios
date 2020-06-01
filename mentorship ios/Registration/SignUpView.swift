//
//  SignUpView.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 01/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
     fileprivate func inputFieldsView() -> some View {
          return VStack {
               TextField("Name", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
               TextField("Username", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
               TextField("Email", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
               SecureField("Password", text: /*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Value@*/.constant("Apple")/*@END_MENU_TOKEN@*/)
               SecureField("Confirm Password", text: /*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Value@*/.constant("Apple")/*@END_MENU_TOKEN@*/)
          }
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
     }
     
     fileprivate func availabilitySelectionView() -> some View {
          return VStack {
               Text("Available to be a:").font(.headline)
               
               Picker(selection: .constant(2), label: Text("")) {
                    Text("Mentor").tag(1)
                    Text("Mentee").tag(2)
                    Text("Both").tag(3)
               }
               .labelsHidden()
               .pickerStyle(SegmentedPickerStyle())
          }
          .padding()
     }
     
     fileprivate func tncConsentView() -> some View {
          return HStack {
               Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                    Text("I confirm that I have read and accept to be bound by the AnitaB.org Code of Conduct, Terms, and Privacy Policy. Further, I consent to the use of my information for the stated purpose.")
                         .font(.caption)
                         .fixedSize(horizontal: false, vertical: true)
               }
          }
          .padding()
     }
     
     var body: some View {
          ScrollView {
               VStack(spacing: 20) {
                    
                    //Sign Up heading
                    Text("Sign Up").font(.largeTitle)
                         .padding(.top)
                    
                    //input fields for name, email, password, etc.
                    inputFieldsView()
                    
                    //select availability as mentor, mentee, or both
                    availabilitySelectionView()
                    
                    //sign up button
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                         Text("Sign Up")
                              .padding([.vertical], 8)
                              .padding([.horizontal], 40)
                              .background(Color.blue)
                              .foregroundColor(.white)
                              .cornerRadius(8)
                              .offset(x: 0, y: 10)
                    }
                    
                    //spacer to separate tncview and push remaining view to top
                    Spacer()
                    
                    //consent view, to accept terms and conditions
                    tncConsentView()
               }
          }
          .background(Color(UIColor.systemGroupedBackground))
          .edgesIgnoringSafeArea(.bottom)
     }
}

struct SignUpView_Previews: PreviewProvider {
     static var previews: some View {
          SignUpView()
     }
}
