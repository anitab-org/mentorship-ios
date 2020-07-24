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
    @Published var deleteAccountResponseData = SettingsModel.DeleteAccountResponseData(message: "", success: false)
    @Published var showUserDeleteAlert = false
    var alertTitle = LocalizedStringKey("")
    
    // MARK: - Functions
    func logout() {
        //delete keychain item
        do {
            try KeychainManager.deleteToken()
        } catch {
            fatalError()
        }
        //go to login screen
        UserDefaults.standard.set(false, forKey: UserDefaultsConstants.isLoggedIn)
    }
}
