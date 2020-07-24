//
//  SignUpViewModel.swift
//  Created on 21/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var signUpData = SignUpModel.SignUpUploadData(name: "", username: "", password: "", email: "", tncChecked: false, needMentoring: true, availableToMentor: false)
    @Published var signUpResponseData = SignUpModel.SignUpResponseData(message: "")
    @Published var confirmPassword: String = ""
    @Published var availabilityPickerSelection: Int = 2
    @Published var inActivity: Bool = false

    var signupDisabled: Bool {
        if signUpData.name.isEmpty || signUpData.username.isEmpty || signUpData.email.isEmpty || signUpData.password.isEmpty || confirmPassword.isEmpty || !signUpData.tncChecked {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Functions
    func update(using data: SignUpModel.SignUpResponseData) {
        signUpResponseData = data
    }

}
