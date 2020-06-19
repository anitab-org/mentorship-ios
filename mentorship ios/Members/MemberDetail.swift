//
//  MemberDetail.swift
//  Created on 08/06/20.
//  Created for AnitaB.org Mentorship-iOS
//

import SwiftUI

struct MemberDetail: View {
    var memberData: MemberProperties
    @State private var showSendRequestSheet = false
    let hideEmptyFields = true
    
    var body: some View {
        List {
            ProfileCommonDetailsSection(memberData: memberData, hideEmptyFields: hideEmptyFields)
        }
        .navigationBarTitle(memberData.name ?? "memberData Detail")
        .navigationBarItems(trailing:
            Button(action: { self.showSendRequestSheet.toggle() }) {
                Text("Send Request")
                    .font(.headline)
        })
        .sheet(isPresented: $showSendRequestSheet) {
            SendRequest(memberID: self.memberData.id, memberName: self.memberData.name ?? "-")
        }
    }
}

struct MemberDetail_Previews: PreviewProvider {
    static var previews: some View {
        MemberDetail(
            memberData: MembersModel.MembersResponseData.init(
                id: 1,
                username: "username",
                name: "yugantar",
                bio: "student",
                location: "earth",
                occupation: "student",
                organization: "",
                interests: "astronomy",
                skills: "ios, swift, c++",
                slackUsername: "",
                needMentoring: true,
                availableToMentor: true,
                isAvailable: true
            )
        )
    }
}
