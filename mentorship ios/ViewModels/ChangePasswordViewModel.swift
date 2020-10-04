//
//  ChangePasswordViewModel.swift
//  Created on 26/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

class ChangePasswordViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var changePasswordData = ChangePasswordModel.ChangePasswordUploadData(currentPassword: "", newPassword: "")
    @Published var changePasswordResponseData = ChangePasswordModel.ChangePasswordResponseData(message: "", success: false)
    @Published var confirmPassword: String = ""
    @Published var inActivity: Bool = false
    
    var changePasswordDisabled: Bool {
        if self.changePasswordData.newPassword.isEmpty || self.changePasswordData.newPassword.isEmpty || self.confirmPassword.isEmpty {
            return true
        }
        return false
    }
    
    func resetData(){
        self.changePasswordData = ChangePasswordModel.ChangePasswordUploadData(currentPassword: "", newPassword: "")
        self.changePasswordResponseData = ChangePasswordModel.ChangePasswordResponseData(message: "", success: false)
        self.confirmPassword = ""
    }
}
