//
//  MembersModel.swift
//  Created on 07/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//


final class MembersModel {

    // MARK: - Structures
    struct MembersResponseData: Decodable, Identifiable, MemberProperties {
        
        let id: Int

        let username: String?
        let name: String?

        let bio: String?
        let location: String?
        let occupation: String?
        let organization: String?
        let interests: String?
        let skills: String?

        let slackUsername: String?
        let needMentoring: Bool?
        let availableToMentor: Bool?
        let isAvailable: Bool?

        enum CodingKeys: String, CodingKey {
            case id, username, name, bio, location, occupation, organization, interests, skills
            case slackUsername = "slack_username"
            case needMentoring = "need_mentoring"
            case availableToMentor = "available_to_mentor"
            case isAvailable = "is_available"
        }
    }

    struct SendRequestUploadData: Encodable {
        var mentorID: Int
        var menteeID: Int
        var endDate: Double
        var notes: String

        enum CodingKeys: String, CodingKey {
            case notes
            case mentorID = "mentor_id"
            case menteeID = "mentee_id"
            case endDate = "end_date"
        }
    }

    struct SendRequestResponseData: Decodable {
        let message: String?
    }

}
