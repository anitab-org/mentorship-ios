//
//  SignUpModel.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 05/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI
import Combine

final class SignUpModel: ObservableObject {
    // MARK: - Variables
    @Published var signUpData = SignUpUploadData(name: "", username: "", password: "", email: "", tncChecked: false, needMentoring: true, availableToMentor: false)
    @Published var signUpResponseData = SignUpResponseData(message: "")
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
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.signUp, httpMethod: "POST", uploadData: uploadData)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.signUpResponseData) }
            .sink(receiveCompletion: { completion in
                self.inActivity = false
            }, receiveValue: { value in
                self.signUpResponseData = value
            })
    }
    
    // MARK: - Structures
    struct SignUpUploadData: Encodable {
        var name: String
        var username: String
        var password: String
        var email: String

        var tncChecked: Bool
        var needMentoring: Bool
        var availableToMentor: Bool
        
        enum CodingKeys: String, CodingKey {
            case name, username, password, email
            case tncChecked = "terms_and_conditions_checked"
            case needMentoring = "need_mentoring"
            case availableToMentor = "available_to_mentor"
        }
    }
    
    struct SignUpResponseData: Decodable {
        var message: String?
    }
}
