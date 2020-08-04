//
//  SettingsModel.swift
//  Created on 26/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

class ChangePasswordModel {
    struct ChangePasswordUploadData: Encodable {
        var currentPassword: String
        var newPassword: String
        
        enum CodingKeys: String, CodingKey {
            case currentPassword = "current_password"
            case newPassword = "new_password"
        }
    }
    
    struct ChangePasswordResponseData: Encodable {
        let message: String?
        var success: Bool
    }
}
