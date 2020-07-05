//
//  ProfileDetailCellsGroup.swift
//  Created on 18/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct ProfileCommonDetailsSection: View {
    var memberData: MemberProperties
    var hideEmptyFields: Bool
    
    var body: some View {
        Section {
            MemberDetailCell(type: .username, value: memberData.username, hideEmptyFields: hideEmptyFields)
            MemberDetailCell(type: .isMentor, value: memberData.availableToMentor ?? false ? "Yes" : "No", hideEmptyFields: hideEmptyFields)
            MemberDetailCell(type: .needsMentor, value: memberData.needMentoring ?? false ? "Yes" : "No", hideEmptyFields: hideEmptyFields)
            MemberDetailCell(type: .interests, value: memberData.interests, hideEmptyFields: hideEmptyFields)
            MemberDetailCell(type: .bio, value: memberData.bio, hideEmptyFields: hideEmptyFields)
            MemberDetailCell(type: .location, value: memberData.location, hideEmptyFields: hideEmptyFields)
            MemberDetailCell(type: .occupation, value: memberData.occupation, hideEmptyFields: hideEmptyFields)
            MemberDetailCell(type: .organization, value: memberData.organization, hideEmptyFields: hideEmptyFields)
            MemberDetailCell(type: .skills, value: memberData.skills, hideEmptyFields: hideEmptyFields)
            MemberDetailCell(type: .slackUsername, value: memberData.slackUsername, hideEmptyFields: hideEmptyFields)
        }
    }
}
