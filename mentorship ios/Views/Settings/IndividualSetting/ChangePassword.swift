//
//  ChangePassword.swift
//  Created on 26/06/20
//  Created for AnitaB.org Mentorship-iOS
//

import SwiftUI

struct ChangePassword: View {
    @ObservedObject var changePasswordViewModel = ChangePasswordViewModel()
    
    var body: some View {
        VStack(spacing: DesignConstants.Form.Spacing.bigSpacing) {
            //input fields
            VStack(spacing: DesignConstants.Form.Spacing.smallSpacing) {
                TextField("Current Password", text: $changePasswordViewModel.changePasswordData.currentPassword)
                    .textFieldStyle(RoundFilledTextFieldStyle())
                TextField("New Password", text: $changePasswordViewModel.changePasswordData.newPassword)
                    .textFieldStyle(RoundFilledTextFieldStyle())
                TextField("Confirm Password", text: $changePasswordViewModel.confirmPassword)
                    .textFieldStyle(RoundFilledTextFieldStyle())
            }
            
            //change password button
            Button("Confirm") {
                self.changePasswordViewModel.changePassword()
            }
            .buttonStyle(BigBoldButtonStyle(disabled: changePasswordViewModel.changePasswordDisabled))
            .disabled(changePasswordViewModel.changePasswordDisabled)
            
            //activity indicator or show user message text
            if self.changePasswordViewModel.inActivity {
                ActivityIndicator(isAnimating: $changePasswordViewModel.inActivity, style: .medium)
            } else {
                Text(self.changePasswordViewModel.changePasswordResponseData.message ?? "")
                    .modifier(ErrorText())
            }
            
            //spacer to push things to top
            Spacer()
        }
        .modifier(AllPadding())
        .navigationBarTitle("Change Password")
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangePassword()
    }
}
