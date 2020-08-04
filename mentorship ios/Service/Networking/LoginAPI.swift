//
//  LoginAPI.swift
//  Created on 23/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

class LoginAPI: LoginService {
    private var cancellable: AnyCancellable?
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func login(
        loginData: LoginModel.LoginUploadData,
        completion: @escaping (LoginModel.LoginResponseData) -> Void
    ) {
        // encode upload data
        guard let uploadData = try? JSONEncoder().encode(loginData) else {
            return
        }
        
        // make network request
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.login, httpMethod: "POST", uploadData: uploadData, session: urlSession)
            .receive(on: RunLoop.main)
            .catch { _ in Just(LoginNetworkModel(message: LocalizableStringConstants.networkErrorString)) }
            .sink { response in
                var loginResponseData = LoginModel.LoginResponseData(message: response.message)
                // if login successful, store access token in keychain
                if var token = response.accessToken {
                    token = "Bearer " + token
                    do {
                        try KeychainManager.setToken(username: loginData.username, tokenString: token)
                        UserDefaults.standard.set(true, forKey: UserDefaultsConstants.isLoggedIn)
                    } catch {
                        loginResponseData.message = "Failed to save access token"
                    }
                }
                // completion handler
                completion(loginResponseData)
        }
    }
    
    struct LoginNetworkModel: Decodable {
        let message: String?
        var accessToken: String?
        
        enum CodingKeys: String, CodingKey {
            case message
            case accessToken = "access_token"
        }
    }
}
