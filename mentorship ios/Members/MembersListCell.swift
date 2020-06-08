//
//  MembersListCell.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 07/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

struct MembersListCell: View {
    var member: MembersModel.MembersResponseData
    var membersModel: MembersModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(member.name ?? "")
                .font(.headline)
            
            Text(self.membersModel.availabilityString(canBeMentee: member.needMentoring ?? false, canBeMentor: member.availableToMentor ?? false))
                .font(.subheadline)
            
            Text(self.membersModel.skillsString(skills: member.skills ?? ""))
                .font(.subheadline)
        }
    }
}

//struct MembersListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MembersListCell(member: MembersModel.MembersResponseData.self, membersModel: MembersModel.self)
//    }
//}
