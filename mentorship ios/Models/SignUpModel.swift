//
//  SignUpModel.swift
//  Created on 05/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

final class SignUpModel {
    
    // MARK: - Structures
    struct SignUpUploadData: Encodable {
        var name: String
        var username: String
        var password: String
        var email: String

        var tncChecked: Bool
        var needMentoring: Bool
        var availableToMentor: Bool

        enum CodingKeys: String, CodingKey {
            case name, username, password, email
            case tncChecked = "terms_and_conditions_checked"
            case needMentoring = "need_mentoring"
            case availableToMentor = "available_to_mentor"
        }
    }

    struct SignUpResponseData: Decodable {
        var message: String?
    }
}
