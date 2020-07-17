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
            List {
                ForEach(membersViewModel.membersResponseData) { member in
                    NavigationLink(destination: MemberDetail(memberData: member)) {
                        MembersListCell(member: member, membersViewModel: self.membersViewModel)
                    }
                }
                
                //show acitivty spinner for loading if members list is not full
                //activity spinner is the last element of list
                //hence its onAppear method is used to load members. Pagination done.
                if !membersViewModel.membersListFull {
                    ActivityIndicator(isAnimating: .constant(true), style: .medium)
                    .onAppear {
                        self.membersViewModel.fetchMembers()
                    }
                }
            }
            .navigationBarTitle(LocalizableStringConstants.ScreenNames.members)
        }
    }
}

struct Members_Previews: PreviewProvider {
    static var previews: some View {
        Members()
    }
}
