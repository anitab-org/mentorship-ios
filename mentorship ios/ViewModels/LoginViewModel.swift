//
//  LoginViewModel.swift
//  Created on 21/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var loginData = LoginModel.LoginUploadData(username: "", password: "")
    @Published var loginResponseData = LoginModel.LoginResponseData(message: "")
    
    var loginDisabled: Bool {
        if self.loginData.username.isEmpty || self.loginData.password.isEmpty {
            return true
        }
        return false
    }
    
    // MARK: Functions
    func update(using data: LoginModel.LoginResponseData) {
        loginResponseData = data
    }
    
}
