//
//  MembersListCell.swift
//  Created on 07/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

//Used in Members.swift for the list of members
struct MembersListCell: View {
    var member: MembersModel.MembersResponseData
    var membersViewModel: MembersViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: DesignConstants.Spacing.minimalSpacing) {
            //Name
            Text(member.name ?? "")
                .font(.headline)

            Group {
                //Availability: mentor and/or mentee
                Text(self.membersViewModel.availabilityString(canBeMentee: member.needMentoring ?? false, canBeMentor: member.availableToMentor ?? false))

                //Skills
                Text(self.membersViewModel.skillsString(skills: member.skills ?? ""))
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
