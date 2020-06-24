//
//  Profile.swift
//  Created on 18/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct ProfileSummary: View {
    @ObservedObject var profileViewModel = ProfileViewModel()
    var profileData: ProfileModel.ProfileData {
        return profileViewModel.getProfile()
    }
    @State private var showProfileEditor = false
    
    var body: some View {
        Form {
            //By using a parent section, the subsections join.
            Section {
                //Name
                MemberDetailCell(type: .name, value: profileData.name ?? "-", hideEmptyFields: false)
                
                //Show common details : name, username, occupation, etc.
                ProfileCommonDetailsSection(memberData: profileData, hideEmptyFields: false)
            }
            
            //Show email
            Text(profileData.email ?? "")
                .font(.subheadline)
                .listRowBackground(DesignConstants.Colors.formBackgroundColor)
        }
        .navigationBarTitle(LocalizableStringConstants.profile)
        .navigationBarItems(trailing:
            Button("Edit") {
                self.showProfileEditor.toggle()
        })
        .sheet(isPresented: $showProfileEditor) {
            ProfileEditor()
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary()
    }
}
