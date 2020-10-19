//
//  ProfileEditor.swift
//  Created on 18/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct ProfileEditor: View {
    var profileService: ProfileService = ProfileAPI()
    @Environment(\.presentationMode) var presentation
    @State var editProfileData = ProfileViewModel().getEditProfileData()
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    // make api call to update profile
    func updateProfile() {
        self.profileService.updateProfile(updateProfileData: self.editProfileData) { response in
            // map model to view model
            response.update(viewModel: self.profileViewModel)
            // set inActivity to false
            self.profileViewModel.inActivity = false
            // show completion alert to user
            self.profileViewModel.showAlert = true
            // success/fail conditions
            if self.profileViewModel.updateProfileResponseData.success ?? false {
                self.profileViewModel.alertTitle = LocalizableStringConstants.success
                // update profile data in user defaults on success
                self.profileViewModel.saveUpdatedProfile(updatedProfileData: self.editProfileData)
            } else {
                self.profileViewModel.alertTitle = LocalizableStringConstants.failure
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    //basic data
                    Section {
                        //name
                        ProfileEditField(type: .name, value: Binding($editProfileData.name)!)
                        //need mentoring
                        Toggle(isOn: Binding($editProfileData.needMentoring)!) {
                            Text(LocalizableStringConstants.ProfileKeys.needsMentor.rawValue).bold()
                        }
                        //can mentor
                        Toggle(isOn: Binding($editProfileData.availableToMentor)!) {
                            Text(LocalizableStringConstants.ProfileKeys.isMentor.rawValue).bold()
                                .frame(width: DesignConstants.Width.listCellTitle)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    //additional details
                    Section {
                        ProfileEditField(type: .bio, value: Binding($editProfileData.bio)!)
                        ProfileEditField(type: .location, value: Binding($editProfileData.location)!)
                        ProfileEditField(type: .occupation, value: Binding($editProfileData.occupation)!)
                        ProfileEditField(type: .organization, value: Binding($editProfileData.organization)!)
                        ProfileEditField(type: .slackUsername, value: Binding($editProfileData.slackUsername)!)
                        ProfileEditField(type: .skills, value: Binding($editProfileData.skills)!)
                        ProfileEditField(type: .interests, value: Binding($editProfileData.interests)!)
                    }
                }
                .disabled(profileViewModel.inActivity)
                
                if profileViewModel.inActivity {
                    ActivityWithText(isAnimating: $profileViewModel.inActivity, textType: .updating)
                }
                
            }
            .navigationBarTitle(LocalizableStringConstants.editProfile)
            .navigationBarItems(leading:
                Button(action: { self.presentation.wrappedValue.dismiss() }) {
                    Text(LocalizableStringConstants.cancel)
                }, trailing: Button(LocalizableStringConstants.save) {
                    self.profileViewModel.inActivity = true
                    // make network call to update profile
                    self.updateProfile()
                })
            .alert(isPresented: $profileViewModel.showAlert) {
                Alert.init(
                    title: Text(profileViewModel.alertTitle),
                    message: Text(profileViewModel.updateProfileResponseData.message ?? ""),
                    dismissButton: .default(Text(LocalizableStringConstants.okay), action: {
                        if self.profileViewModel.alertTitle == LocalizableStringConstants.success {
                            self.presentation.wrappedValue.dismiss()
                        }
                    }))
            }
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor()
    }
}
