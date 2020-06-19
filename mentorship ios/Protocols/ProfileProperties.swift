//
//  ProfileProperties.swift
//  Created on 18/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation

protocol MemberProperties {
    var id: Int { get }
    var name: String? { get }
    var username: String? { get }
    var bio: String? { get }
    var location: String? { get }
    var occupation: String? { get }
    var organization: String? { get }
    var slackUsername: String? { get }
    var skills: String? { get }
    var interests: String? { get }
    var needMentoring: Bool? { get }
    var availableToMentor: Bool? { get }
}

protocol ProfileProperties: MemberProperties {
    var id: Int { get }
    var name: String? { get set }
    var username: String? { get set }
    var bio: String? { get set }
    var location: String? { get set }
    var occupation: String? { get set }
    var organization: String? { get set }
    var slackUsername: String? { get set }
    var skills: String? { get set }
    var interests: String? { get set }
    var needMentoring: Bool? { get set }
    var availableToMentor: Bool? { get set }
}
