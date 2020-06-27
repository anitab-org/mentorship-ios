//
//  SettingsModel.swift
//  Created on 27/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

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
    }
    
    struct DeleteAccountResponseData: Decodable {
        let message: String?
    }
    
}
