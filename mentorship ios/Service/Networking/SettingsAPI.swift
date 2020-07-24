//
//  SettingsAPI.swift
//  Created on 24/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

class SettingsAPI: SettingsService {
    private var cancellable: AnyCancellable?

    // Delete Account
    func deleteAccount(completion: @escaping (SettingsModel.DeleteAccountResponseData) -> Void) {
        //get token
        guard let token = try? KeychainManager.getToken() else {
            return
        }
        
        //api call
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.user, httpMethod: "DELETE", token: token)
            .receive(on: RunLoop.main)
            .catch { _ in Just(NetworkResponseModel(message: LocalizableStringConstants.networkErrorString)) }
            .sink {
                let success = NetworkManager.responseCode == 200
                let responseData = SettingsModel.DeleteAccountResponseData(message: $0.message, success: success)
                completion(responseData)
            }
    }
    
    // Change Password
    func changePassword(
        changePasswordData: ChangePasswordModel.ChangePasswordUploadData,
        confirmPassword: String,
        completion: @escaping (ChangePasswordModel.ChangePasswordResponseData) -> Void
    ) {
        //check password fields
        if changePasswordData.newPassword != confirmPassword {
            completion(ChangePasswordModel.ChangePasswordResponseData(message: LocalizableStringConstants.passwordsDoNotMatch, success: false))
            return
        }
        
        //get auth token
        guard let token = try? KeychainManager.getToken() else {
            return
        }

        //encode upload data
        guard let uploadData = try? JSONEncoder().encode(changePasswordData) else {
            return
        }
        
        //api call
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.changePassword, httpMethod: "PUT", uploadData: uploadData, token: token)
            .receive(on: RunLoop.main)
            .catch { _ in Just(NetworkResponseModel(message: LocalizableStringConstants.networkErrorString)) }
            .sink { response in
                let success = NetworkManager.responseCode == 201
                let responseData = ChangePasswordModel.ChangePasswordResponseData(message: response.message, success: success)
                completion(responseData)
        }
    }
    
    struct NetworkResponseModel: Decodable {
        let message: String?
    }
}
