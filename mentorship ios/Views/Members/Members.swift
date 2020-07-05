//
//  Members.swift
//  Created on 07/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct Members: View {
    @ObservedObject var membersViewModel = MembersViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if self.membersViewModel.inActivity {
                    ActivityIndicator(isAnimating: self.$membersViewModel.inActivity, style: .medium)
                } else {
                    List {
                        ForEach(membersViewModel.membersResponseData) { member in
                            NavigationLink(destination: MemberDetail(memberData: member)) {
                                MembersListCell(member: member, membersViewModel: self.membersViewModel)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(LocalizableStringConstants.ScreenNames.members)
            .onAppear {
                if self.membersViewModel.membersResponseData.count == 0 {
                    self.membersViewModel.fetchMembers()
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
