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
        membersService.fetchMembers(pageToLoad: membersViewModel.currentPage + 1, perPage: membersViewModel.perPage, search: membersViewModel.searchString) { members, listFull in
            // to go in update func
            self.membersViewModel.currentPage += 1
            self.membersViewModel.membersResponseData.append(contentsOf: members)
            //if number of members received are less than perPage value
            //then it is last page. Used to disable loading in view.
            self.membersViewModel.membersListFull = listFull
            // if showing original data, backup
            if self.membersViewModel.currentlySearching == false {
                self.membersViewModel.backup()
            }
        }
    }
    
    func search() {
        membersViewModel.currentlySearching = true
        // reset current page
        membersViewModel.currentPage = 0
        // reset members
        membersViewModel.membersResponseData.removeAll()
        // reset list full value
        // this shows activity indicator which automatically calls fetch members.
        membersViewModel.membersListFull = false
    }
    
    func cancelSearch() {
        membersViewModel.searchString = ""
        membersViewModel.restore()
    }

    var body: some View {
        SearchNavigation(text: $membersViewModel.searchString, search: search, cancel: cancelSearch) {
            // Members List
            List {
                if self.membersViewModel.membersListFull && self.membersViewModel.membersResponseData.count == 0 {
                    Text("No member found")
                }
                
                ForEach(self.membersViewModel.membersResponseData) { member in
                    NavigationLink(destination: MemberDetail(memberData: member)) {
                        MembersListCell(member: member, membersViewModel: self.membersViewModel)
                    }
                }
                
                //show acitivty spinner for loading if members list is not full
                //activity spinner is the last element of list
                //hence its onAppear method is used to load members. Pagination done.
                if !self.membersViewModel.membersListFull {
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
