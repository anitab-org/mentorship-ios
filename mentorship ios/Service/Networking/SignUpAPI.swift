//
//  SignUpAPI.swift
//  Created on 23/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

class SignUpAPI: SignUpService {
    private var cancellable: AnyCancellable?
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func signUp(
        availabilityPickerSelection: Int,
        signUpData: SignUpModel.SignUpUploadData,
        confirmPassword: String,
        completion: @escaping (SignUpModel.SignUpResponseData) -> Void
    ) {
        // make variable for sign up data
        var signUpData = signUpData
        
        //assign availability values as per picker selection
        signUpData.needMentoring = availabilityPickerSelection > 1
        signUpData.availableToMentor = availabilityPickerSelection != 2

        //check password fields
        if signUpData.password != confirmPassword {
            let signUpResponseData = SignUpModel.SignUpResponseData(message: LocalizableStringConstants.passwordsDoNotMatch)
            completion(signUpResponseData)
            return
        }

        //encode upload data
        guard let uploadData = try? JSONEncoder().encode(signUpData) else {
            return
        }
        
        //api call
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.signUp, httpMethod: "POST", uploadData: uploadData, session: urlSession)
            .receive(on: RunLoop.main)
            .catch { _ in Just(SignUpNetworkModel(message: LocalizableStringConstants.networkErrorString)) }
            .sink {
                let signUpResponseData = SignUpModel.SignUpResponseData(message: $0.message)
                completion(signUpResponseData)
        }
    }
    
    struct SignUpNetworkModel: Decodable {
        var message: String?
    }
}
