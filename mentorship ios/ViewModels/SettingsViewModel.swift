//
//  SettingsViewModel.swift
//  Created on 27/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
    
    //MARK: - Variables
    let settingsData = SettingsModel.SettingsData()
    let destinationViews = UIHelper().settingsViews
    @Published var deleteAccountResponseData = SettingsModel.DeleteAccountResponseData(message: "")
    @Published var successfullyDeleted = false
    @Published var showUserDeleteAlert = false
    var alertTitle = LocalizedStringKey("")
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
                //Show alert after call completes
                self.showUserDeleteAlert = true
                if NetworkManager.responseCode == 200 {
                    self.successfullyDeleted = true
                    self.alertTitle = LocalizableStringConstants.success
                } else {
                    self.alertTitle = LocalizableStringConstants.failure
                }
            }
    }
}
