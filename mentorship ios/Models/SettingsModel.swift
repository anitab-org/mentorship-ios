//
//  SettingsModel.swift
//  Created on 27/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import SwiftUI

class SettingsModel {
    
    //MARK: - Structures
    struct SettingsData {
        let settingsOptions = [
            ["About", "Feedback", "Change Password"],
            ["Logout", "Delete Account"]
        ]
        
        let settingsIcons = [
            [ImageNameConstants.SFSymbolConstants.about,
             ImageNameConstants.SFSymbolConstants.feedback,
             ImageNameConstants.SFSymbolConstants.changePassword],
            [ImageNameConstants.SFSymbolConstants.logout,
             ImageNameConstants.SFSymbolConstants.deleteAccount]
        ]
        
        let settingsViews: [AnyView] = [
            AnyView(About()), AnyView(Text("Feedback")), AnyView(ChangePassword())
        ]
    }
    
    struct DeleteAccountResponseData: Decodable {
        let message: String
    }
    
}
