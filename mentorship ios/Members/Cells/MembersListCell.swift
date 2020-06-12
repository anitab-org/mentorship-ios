//
//  MembersListCell.swift
//  Created on 07/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct MembersListCell: View {
    var member: MembersModel.MembersResponseData
    var membersModel: MembersModel
    var body: some View {
        VStack(alignment: .leading, spacing: DesignConstants.Spacing.minimalSpacing) {
            Text(member.name ?? "")
                .font(.headline)

            Group {
                Text(self.membersModel.availabilityString(canBeMentee: member.needMentoring ?? false, canBeMentor: member.availableToMentor ?? false))

                Text(self.membersModel.skillsString(skills: member.skills ?? ""))
            }
            .font(.subheadline)
            .foregroundColor(DesignConstants.Colors.subtitleText)
        }
    }
}

//struct MembersListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MembersListCell(member: MembersModel.MembersResponseData.self, membersModel: MembersModel.self)
//    }
//}
