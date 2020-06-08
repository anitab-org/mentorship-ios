//
//  Members.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 07/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

struct Members: View {
    @ObservedObject var membersModel = MembersModel()
    
    var body: some View {
        NavigationView {
            List {
                if self.membersModel.inActivity {
                    ActivityIndicator(isAnimating: self.$membersModel.inActivity, style: .medium)
                }
                ForEach(membersModel.membersResponseData) { member in
                    NavigationLink(destination: Text("member page")) {
                        MembersListCell(member: member, membersModel: self.membersModel)
                    }
                }
            }
            .navigationBarTitle("Members")
            .onAppear {
                if self.membersModel.membersResponseData.count == 0 {
                    self.membersModel.fetchMembers()
                }
            }
        }
    }
}

struct Members_Previews: PreviewProvider {
    static var previews: some View {
        Members()
    }
}
