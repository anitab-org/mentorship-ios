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
    
    private func makeSignInNetworkRequest(urlString: String, uploadData: Data, keychainUsername: String, completion: @escaping (LoginModel.LoginResponseData) -> Void) {
        // make network request
        cancellable = NetworkManager.callAPI(urlString: urlString, httpMethod: "POST", uploadData: uploadData, session: urlSession)
            .receive(on: RunLoop.main)
            .catch { _ in Just(LoginNetworkModel(message: LocalizableStringConstants.networkErrorString)) }
            .sink { response in
                var loginResponseData = LoginModel.LoginResponseData(message: response.message)
                // if login successful, store access token in keychain
                if var token = response.accessToken {
                    token = "Bearer " + token
                    do {
                        try KeychainManager.setToken(username: keychainUsername, tokenString: token)
                        UserDefaults.standard.set(true, forKey: UserDefaultsConstants.isLoggedIn)
                    } catch {
                        loginResponseData.message = "Failed to save access token"
                    }
                }
                // completion handler
                completion(loginResponseData)
        }
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
        makeSignInNetworkRequest(
            urlString: URLStringConstants.Users.login,
            uploadData: uploadData,
            keychainUsername: loginData.username) { response in
                completion(response)
        }
    }
    
    func socialSignInCallback(
        socialSignInData: LoginModel.SocialSignInData,
        socialSignInType: LoginModel.SocialSignInType,
        completion: @escaping (LoginModel.LoginResponseData) -> Void
    ) {
        // encode upload data
        guard let uploadData = try? JSONEncoder().encode(socialSignInData) else {
            return
        }
        
        // set URL depending upon auth provider used
        var urlString = ""
        switch socialSignInType {
        case .apple:
            urlString = URLStringConstants.Users.appleAuthCallback
        case .google:
            urlString = URLStringConstants.Users.googleAuthCallback
        }
        
        // make network request
        makeSignInNetworkRequest(
            urlString: urlString,
            uploadData: uploadData,
            keychainUsername: socialSignInData.email) { response in
                completion(response)
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
