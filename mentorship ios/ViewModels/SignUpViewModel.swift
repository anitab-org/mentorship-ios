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
    private var cancellable: AnyCancellable?

    var signupDisabled: Bool {
        if signUpData.name.isEmpty || signUpData.username.isEmpty || signUpData.email.isEmpty || signUpData.password.isEmpty || confirmPassword.isEmpty || !signUpData.tncChecked {
            return true
        } else {
            return false
        }
    }

    // MARK: - Main Function
    func signUp() {
        //assign availability values as per picker selection
        if self.availabilityPickerSelection > 1 {
            self.signUpData.needMentoring = true
        }
        if self.availabilityPickerSelection != 2 {
            self.signUpData.availableToMentor = true
        }

        //check password fields
        if self.signUpData.password != self.confirmPassword {
            self.signUpResponseData.message = "Passwords do not match"
            return
        }

        //show activity indicator
        self.inActivity = true

        guard let uploadData = try? JSONEncoder().encode(signUpData) else {
            self.inActivity = false
            return
        }
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.signUp, httpMethod: "POST", uploadData: uploadData)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.signUpResponseData) }
            .sink(receiveCompletion: { _ in
                self.inActivity = false
            }, receiveValue: { value in
                self.signUpResponseData = value
            })
    }

}
