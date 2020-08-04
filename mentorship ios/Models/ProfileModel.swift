//
//  ProfileModel.swift
//  Created on 12/06/20.
//  Created for AnitaB.org Mentorship-iOS
//

final class ProfileModel {

    // MARK: - Structures
    struct ProfileData: Codable, Equatable, ProfileProperties {
        let id: Int
        var name: String?
        var username: String?
        let email: String?
        var bio: String?
        var location: String?
        var occupation: String?
        var organization: String?
        var slackUsername: String?
        var skills: String?
        var interests: String?
        var needMentoring: Bool?
        var availableToMentor: Bool?

        enum CodingKeys: String, CodingKey {
            case id, name, username, email, bio, location, occupation, organization, skills, interests
            case slackUsername = "slack_username"
            case needMentoring = "need_mentoring"
            case availableToMentor = "available_to_mentor"
        }
    }
    
    struct UpdateProfileResponseData: Encodable {
        let success: Bool?
        let message: String?
    }

}

// MARK: - API
extension ProfileModel.ProfileData {
    func update(viewModel: HomeViewModel) {
        viewModel.userName = self.name
    }
}

extension ProfileModel.UpdateProfileResponseData {
    func update(viewModel: ProfileViewModel) {
        viewModel.updateProfileResponseData = self
    }
}
