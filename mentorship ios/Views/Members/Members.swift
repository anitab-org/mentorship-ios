//
//  Members.swift
//  Created on 07/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct Members: View {
    var membersService: MembersService = MembersAPI()
    @ObservedObject var membersViewModel = MembersViewModel()
    
    // use service and fetch members
    func fetchMembers() {
        membersService.fetchMembers(pageToLoad: membersViewModel.currentPage + 1, perPage: membersViewModel.perPage) { members, listFull in
            self.membersViewModel.inActivity = false
            // to go in update func
            self.membersViewModel.currentPage += 1
            self.membersViewModel.membersResponseData.append(contentsOf: members)
            //if number of members received are less than perPage value
            //then it is last page. Used to disable loading in view.
            self.membersViewModel.membersListFull = listFull
        }
    }

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
                    ActivityIndicator(isAnimating: .constant(true))
                    .onAppear {
                        self.fetchMembers()
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
