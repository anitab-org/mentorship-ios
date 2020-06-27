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
    @Published var changePasswordResponseData = ChangePasswordModel.ChangePasswordResponseData(message: "")
    @Published var confirmPassword: String = ""
    @Published var inActivity: Bool = false
    @Published var updatedSuccessfully: Bool = false
    private var cancellable: AnyCancellable?
    
    var changePasswordDisabled: Bool {
        if self.changePasswordData.newPassword.isEmpty || self.changePasswordData.newPassword.isEmpty || self.confirmPassword.isEmpty {
            return true
        }
        return false
    }
    
    // MARK: - Change Password
    func changePassword() {
        //check password fields
        if self.changePasswordData.newPassword != self.confirmPassword {
            self.changePasswordResponseData.message = "Passwords do not match"
            return
        }
        
        //get auth token
        guard let token = try? KeychainManager.readKeychain() else {
            return
        }
        
        //show activity indicator
        self.inActivity = true

        //encode upload data
        guard let uploadData = try? JSONEncoder().encode(changePasswordData) else {
            self.inActivity = false
            return
        }
        
        //api call
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.changePassword, httpMethod: "PUT", uploadData: uploadData, token: token)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.changePasswordResponseData) }
            .sink { response in
                if NetworkManager.responseCode == 201 {
                    self.updatedSuccessfully = true
                }
                self.changePasswordResponseData = response
                self.inActivity = false
        }
    }
}
