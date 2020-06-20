//
//  SettingsModel.swift
//  Created on 20/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation

struct SettingsModel {
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
