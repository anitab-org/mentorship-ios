//
//  SignUpView.swift
//  Created on 01/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct SignUp: View {
    @ObservedObject var signUpModel = SignUpModel()
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: DesignConstants.Form.Spacing.bigSpacing) {
                    //input fields for name, email, password, etc.
                    VStack(spacing: DesignConstants.Form.Spacing.smallSpacing) {
                        TextField("Name", text: $signUpModel.signUpData.name)
                            .textFieldStyle(RoundFilledTextFieldStyle())
                        TextField("Username", text: $signUpModel.signUpData.username)
                            .textFieldStyle(RoundFilledTextFieldStyle())
                        TextField("Email", text: $signUpModel.signUpData.email)
                            .textFieldStyle(RoundFilledTextFieldStyle())
                            .autocapitalization(.none)
                        SecureField("Password", text: $signUpModel.signUpData.password)
                            .textFieldStyle(RoundFilledTextFieldStyle())
                        SecureField("Confirm Password", text: $signUpModel.confirmPassword)
                            .textFieldStyle(RoundFilledTextFieldStyle())
                    }

                    //select availability as mentor, mentee, or both
                    VStack {
                        Text(LocalizableStringConstants.availabilityText).font(.headline)

                        Picker(selection: $signUpModel.availabilityPickerSelection, label: Text("")) {
                            Text(LocalizableStringConstants.mentor).tag(1)
                            Text(LocalizableStringConstants.mentee).tag(2)
                            Text("Both").tag(3)
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    //sign up button
                    Button("Sign Up") {
                        self.signUpModel.signUp()
                    }
                    .buttonStyle(BigBoldButtonStyle(disabled: signUpModel.signupDisabled))
                    .disabled(signUpModel.signupDisabled)

                    //activity indicator or message for user if present
                    if signUpModel.inActivity {
                        ActivityIndicator(isAnimating: $signUpModel.inActivity, style: .medium)
                    } else if !(self.signUpModel.signUpResponseData.message?.isEmpty ?? true) {
                        Text(self.signUpModel.signUpResponseData.message ?? "")
                        .modifier(ErrorText())
                    }

                    //consent view, to accept terms and conditions
                    VStack(spacing: DesignConstants.Form.Spacing.minimalSpacing + 2) {
                        Toggle(isOn: $signUpModel.signUpData.tncChecked) {
                            Text("Terms and Conditions")
                                .font(.headline)
                        }

                        Text(LocalizableStringConstants.tncString)
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    //spacer to push content to top and have bottom space for scroll view
                    Spacer()
                }
                .modifier(AllPadding())
            }
            .navigationBarTitle("Sign Up")
            .navigationBarItems(leading:
                Button.init(action: {
                    self.isPresented = false
                }, label: {
                    Image(systemName: ImageNameConstants.SFSymbolConstants.xCircle)
                        .font(.headline)
                        .accentColor(.secondary)
                })
            )
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUp(isPresented: .constant(true))
    }
}
