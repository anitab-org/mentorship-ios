//
//  ProfileModel.swift
//  Created on 12/06/20.
//  Created for AnitaB.org Mentorship-iOS
//

import SwiftUI
import Combine

final class ProfileModel: ObservableObject {
    
    // MARK: - Variables
    var profileData = ProfileData(
        id: 0,
        name: "",
        username: "",
        email: "",
        bio: "",
        location: "",
        occupation: "",
        organization: "",
        slackUsername: "",
        skills: "",
        interests: "",
        needMentoring: false,
        availableToMentor: false
    )

    // MARK: - Functions
    func saveProfile(profile: ProfileData) {
        guard let profileData = try? JSONEncoder().encode(profile) else {
            return
        }
        UserDefaults.standard.set(profileData, forKey: UserDefaultsConstants.profile)
    }
    
    func getProfile() -> ProfileData {
        let profileData = UserDefaults.standard.data(forKey: UserDefaultsConstants.profile)
        guard let profile = try? JSONDecoder().decode(ProfileData.self, from: profileData!) else {
            return self.profileData
        }
        return profile
    }

    // MARK: - Structures
    struct ProfileData: Codable {
        let id: Int
        let name: String?
        let username: String?
        let email: String?
        let bio: String?
        let location: String?
        let occupation: String?
        let organization: String?
        let slackUsername: String?
        let skills: String?
        let interests: String?
        let needMentoring: Bool?
        let availableToMentor: Bool?
        
        enum CodingKeys: String, CodingKey {
            case id, name, username, email, bio, location, occupation, organization, skills, interests
            case slackUsername = "slack_username"
            case needMentoring = "need_mentoring"
            case availableToMentor = "available_to_mentor"
        }
    }
    
}
