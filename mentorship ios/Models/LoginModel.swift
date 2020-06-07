//
//  LoginModel.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 05/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI
import Combine

final class LoginModel: ObservableObject {
    //MARK: - Variables
    @Published var loginData = LoginUploadData(username: "", password: "")
    @Published var loginResponseData = LoginResponseData(message: "", access_token: "")
    @Published var inActivity: Bool = false
    private var cancellable: AnyCancellable?
    
    var loginDisabled: Bool {
        if self.loginData.username.isEmpty || self.loginData.password.isEmpty {
            return true
        }
        return false
    }
     
    //MARK: - Main Function
    func login() {
        self.inActivity = true
        
        guard let uploadData = try? JSONEncoder().encode(loginData) else {
            self.inActivity = false
            return
        }
        
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.login, httpMethod: "POST", uploadData: uploadData)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.loginResponseData) }
            .sink(receiveCompletion: { completion in
                self.inActivity = false
            }, receiveValue: { value in
                self.loginResponseData = value
                //if login successful, store access token in keychain
                if var token = value.access_token {
                    token = "Bearer " + token
                    do {
                        try KeychainManager.addToKeychain(username: self.loginData.username, tokenString: token)
                        print("added")
                    } catch {
                        print("not added")
                        return
                    }
                }
            })
    }
    
    //MARK: - Structures
    struct LoginUploadData: Encodable {
        var username: String
        var password: String
    }

    struct LoginResponseData: Decodable {
        let message: String?
        let access_token: String?
    }
}
