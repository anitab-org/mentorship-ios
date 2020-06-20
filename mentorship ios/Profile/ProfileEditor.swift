//
//  ProfileEditor.swift
//  Created on 18/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct ProfileEditor: View {
    @Environment(\.presentationMode) var presentation
    @State var editProfileData = ProfileModel().getEditProfileData()
    @ObservedObject var profileModel = ProfileModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
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
                .disabled(profileModel.inActivity)
                
                if profileModel.inActivity {
                    ActivityWithText(isAnimating: $profileModel.inActivity, textType: .updating)
                }
                
            }
            .modifier(KeyboardAware())
            .navigationBarTitle(LocalizableStringConstants.editProfile)
            .navigationBarItems(leading:
                Button(action: { self.presentation.wrappedValue.dismiss() }) {
                    Text(LocalizableStringConstants.cancel)
                }, trailing: Button(LocalizableStringConstants.save) {
                    self.profileModel.updateProfile(updateProfileData: self.editProfileData)
                })
            .alert(isPresented: $profileModel.showAlert) {
                Alert.init(
                    title: Text(profileModel.alertTitle),
                    message: Text(profileModel.updateProfileResponseData.message ?? ""),
                    dismissButton: .default(Text(LocalizableStringConstants.okay), action: {
                        if self.profileModel.alertTitle == LocalizableStringConstants.success {
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
