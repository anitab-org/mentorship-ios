//
//  LoginView.swift
//  Created on 01/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct Login: View {
    @State private var showSignUpPage: Bool = false
    @ObservedObject var loginModel = LoginModel()

    var body: some View {
        VStack(spacing: DesignConstants.Form.Spacing.bigSpacing) {
            //top image of mentorship logo
            Image(ImageNameConstants.mentorshipLogoImageName)
                .resizable()
                .scaledToFit()

            //username and password text fields
            VStack(spacing: DesignConstants.Form.Spacing.smallSpacing) {
                TextField("Username/Email", text: $loginModel.loginData.username)
                    .textFieldStyle(RoundFilledTextFieldStyle())
                    .autocapitalization(.none)

                SecureField("Password", text: $loginModel.loginData.password)
                    .textFieldStyle(RoundFilledTextFieldStyle())
            }

            //login button
            Button("Login") {
                self.loginModel.login()
            }
            .buttonStyle(BigBoldButtonStyle(disabled: loginModel.loginDisabled))
            .disabled(loginModel.loginDisabled)

            //activity indicator or show user message text
            if self.loginModel.inActivity {
                ActivityIndicator(isAnimating: $loginModel.inActivity, style: .medium)
            } else {
                Text(self.loginModel.loginResponseData.message ?? "")
                    .modifier(ErrorText())
            }

            //text and sign up button
            VStack(spacing: DesignConstants.Form.Spacing.minimalSpacing) {
                Text(LocalizableStringConstants.noAccountText)

                Button.init(action: { self.showSignUpPage.toggle() }) {
                    Text("Signup")
                        .foregroundColor(DesignConstants.Colors.defaultIndigoColor)
                }.sheet(isPresented: $showSignUpPage) {
                    SignUp(isPresented: self.$showSignUpPage)
                }
            }

            //spacer to push content to top
            Spacer()
        }
        .modifier(AllPadding())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
