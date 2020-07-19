//
//  SignUpView.swift
//  Created on 01/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct SignUp: View {
    @ObservedObject var signUpViewModel = SignUpViewModel()
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: DesignConstants.Form.Spacing.bigSpacing) {
                    //input fields for name, email, password, etc.
                    VStack(spacing: DesignConstants.Form.Spacing.smallSpacing) {
                        TextField("Name", text: $signUpViewModel.signUpData.name)
                            .textFieldStyle(RoundFilledTextFieldStyle())
                        TextField("Username", text: $signUpViewModel.signUpData.username)
                            .textFieldStyle(RoundFilledTextFieldStyle())
                        TextField("Email", text: $signUpViewModel.signUpData.email)
                            .textFieldStyle(RoundFilledTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        SecureField("Password", text: $signUpViewModel.signUpData.password)
                            .textFieldStyle(RoundFilledTextFieldStyle())
                        SecureField("Confirm Password", text: $signUpViewModel.confirmPassword)
                            .textFieldStyle(RoundFilledTextFieldStyle())
                    }

                    //select availability as mentor, mentee, or both
                    VStack {
                        Text(LocalizableStringConstants.availabilityText).font(.headline)

                        Picker(selection: $signUpViewModel.availabilityPickerSelection, label: Text("")) {
                            Text(LocalizableStringConstants.mentor).tag(1)
                            Text(LocalizableStringConstants.mentee).tag(2)
                            Text("Both").tag(3)
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    //sign up button
                    Button("Sign Up") {
                        self.signUpViewModel.signUp()
                    }
                    .buttonStyle(BigBoldButtonStyle(disabled: signUpViewModel.signupDisabled))
                    .disabled(signUpViewModel.signupDisabled)

                    //activity indicator or message for user if present
                    if signUpViewModel.inActivity {
                        ActivityIndicator(isAnimating: $signUpViewModel.inActivity, style: .medium)
                    } else if !(self.signUpViewModel.signUpResponseData.message?.isEmpty ?? true) {
                        Text(self.signUpViewModel.signUpResponseData.message ?? "")
                        .modifier(ErrorText())
                    }

                    //consent view, to accept terms and conditions
                    VStack(spacing: DesignConstants.Form.Spacing.minimalSpacing + 2) {
                        Toggle(isOn: $signUpViewModel.signUpData.tncChecked) {
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
