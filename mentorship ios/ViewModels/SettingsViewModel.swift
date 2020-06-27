//
//  SettingsViewModel.swift
//  Created on 27/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

class SettingsViewModel {
    
    //MARK: - Variables
    @Published var deleteAccountResponseData = SettingsModel.DeleteAccountResponseData(message: "")
    let settingsData = SettingsModel.SettingsData()
    private var cancellable: AnyCancellable?
    
    // MARK: - Functions
    func logout() {
        //delete keychain item
        do {
            try KeychainManager.deleteTokenFromKeychain()
        } catch {
            fatalError()
        }
        //go to login screen
        UserDefaults.standard.set(false, forKey: UserDefaultsConstants.isLoggedIn)
    }
    
    func deleteAccount() {
        //get token
        guard let token = try? KeychainManager.readKeychain() else {
            return
        }
        
        //api call
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.user, httpMethod: "DELETE", token: token)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.deleteAccountResponseData) }
            .sink {
                self.deleteAccountResponseData = $0
        }
        
    }
}
