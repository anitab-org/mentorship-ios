//
//  ChangePassword.swift
//  Created on 26/06/20
//  Created for AnitaB.org Mentorship-iOS
//

import SwiftUI

struct ChangePassword: View {
    var settingsService: SettingsService = SettingsAPI()
    @ObservedObject var changePasswordViewModel = ChangePasswordViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    // use service to change password
    func changePassword() {
        self.changePasswordViewModel.inActivity = true
        // make request
        self.settingsService.changePassword(
            changePasswordData: self.changePasswordViewModel.changePasswordData,
            confirmPassword: self.changePasswordViewModel.confirmPassword) { response in
                self.changePasswordViewModel.changePasswordResponseData = response
                self.changePasswordViewModel.inActivity = false
        }
    }
    
    var body: some View {
        VStack(spacing: DesignConstants.Form.Spacing.bigSpacing) {
            //input fields
            VStack(spacing: DesignConstants.Form.Spacing.smallSpacing) {
                SecureField("Current Password", text: $changePasswordViewModel.changePasswordData.currentPassword)
                    .textFieldStyle(RoundFilledTextFieldStyle())
                SecureField("New Password", text: $changePasswordViewModel.changePasswordData.newPassword)
                    .textFieldStyle(RoundFilledTextFieldStyle())
                SecureField("Confirm Password", text: $changePasswordViewModel.confirmPassword)
                    .textFieldStyle(RoundFilledTextFieldStyle())
            }
            
            //change password button
            Button(LocalizableStringConstants.confirm) {
                self.changePassword()
            }
            .buttonStyle(BigBoldButtonStyle(disabled: changePasswordViewModel.changePasswordDisabled))
            .disabled(changePasswordViewModel.changePasswordDisabled)
            
            //activity indicator or show user message text
            if self.changePasswordViewModel.inActivity {
                ActivityIndicator(isAnimating: $changePasswordViewModel.inActivity, style: .medium)
            } else if !self.changePasswordViewModel.changePasswordResponseData.success {
                Text(self.changePasswordViewModel.changePasswordResponseData.message ?? "An error occurred")
                    .modifier(ErrorText())
            }
            
            //spacer to push things to top
            Spacer()
        }
        .modifier(AllPadding())
        .navigationBarTitle("Change Password")
        .alert(isPresented: $changePasswordViewModel.changePasswordResponseData.success) {
            Alert(
                title: Text(LocalizableStringConstants.success),
                message: Text(self.changePasswordViewModel.changePasswordResponseData.message ?? "Password updated successfully"),
                dismissButton: .default(Text(LocalizableStringConstants.okay)) {
                    //pop navigation view after okay button pressed
                    self.presentationMode.wrappedValue.dismiss()
                    self.changePasswordViewModel.changePasswordResponseData.success = true
                })
        }
        .onDisappear {
            self.changePasswordViewModel.resetData()
        }
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangePassword()
    }
}
