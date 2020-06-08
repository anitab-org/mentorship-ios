//
//  MembersModel.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 07/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI
import Combine

final class MembersModel: ObservableObject {
    
    // MARK: - Variables
    @Published var membersResponseData = [MembersResponseData]()
    @Published var inActivity: Bool = false
    private var cancellable: AnyCancellable?
    
    // MARK: - Functions
    func fetchMembers() {
        guard let token = try? KeychainManager.readKeychain() else {
            return
        }
        
        self.inActivity = true

        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.members, httpMethod: "GET", uploadData: Data(), token: token)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.membersResponseData) }
            .sink(receiveCompletion: { completion in
                if completion == .finished {
                    self.inActivity = false
                }
            }, receiveValue: { value in
                self.membersResponseData = value
                print(value)
            })
    }
    
    func availabilityString(canBeMentee: Bool, canBeMentor: Bool) -> String {
        if canBeMentor && canBeMentor {
            return "Available to be a Mentor and Mentee both"
        } else if canBeMentee {
            return "Available to be a Mentee"
        } else if canBeMentor {
            return "Availbe to be a Mentor"
        } else {
            return "Not available"
        }
    }
    
    func skillsString(skills: String) -> String {
        return "Skills: \(skills)"
    }
    
    // MARK: - Structures
    struct MembersResponseData: Decodable, Identifiable {
        let id: Int?
        
        let username: String?
        let name: String?
        
        let bio: String?
        let location: String?
        let occupation: String?
        let organization: String?
        let skills: String?
        
        let slackUsername: String?
        let needMentoring: Bool?
        let availableToMentor: Bool?
        let isAvailable: Bool?
        
        enum CodingKeys: String, CodingKey {
            case id, username, name, bio, location, occupation, organization, skills
            
            case slackUsername = "slack_username"
            case needMentoring = "need_mentoring"
            case availableToMentor = "available_to_mentor"
            case isAvailable = "is_available"
        }
    }
    
}
