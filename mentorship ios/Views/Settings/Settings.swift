//
//  Settings.swift
//  Created on 20/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct Settings: View {
    @ObservedObject var settingsViewModel = SettingsViewModel()
    //Alert used for logout and delete action, to confirm user's action before proceeding.
    @State var showAlert = false
    @State var alertTitle = ""
    
    func logoutOrDelete(actionName: String) {
        //LOG OUT
        if actionName == self.settingsViewModel.settingsData.settingsOptions[1][0] {
            settingsViewModel.logout()
        }
        //DELETE ACCOUNT
        else {
            settingsViewModel.deleteAccount()
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                //Top Space
                Section { EmptyView() }
                
                //Section 1 of settings : about, feedback, and change password
                Section {
                    ForEach(0 ..< settingsViewModel.settingsData.settingsOptions[0].count, id: \.self) { index in
                        NavigationLink(destination: self.settingsViewModel.settingsData.settingsViews[index]) {
                            //Setting list cell
                            HStack {
                                //icon image
                                Image(systemName: self.settingsViewModel.settingsData.settingsIcons[0][index])
                                    .imageScale(.large)
                                    .frame(width: 40, height: 40)
                                
                                //text
                                Text(self.settingsViewModel.settingsData.settingsOptions[0][index])
                            }
                        }
                    }
                }
                
                //Section 2 of settings : logout, and delete account
                Section {
                    ForEach(0 ..< settingsViewModel.settingsData.settingsOptions[1].count, id: \.self) { index in
                        //setting list cell
                        HStack {
                            //icon image
                            Image(systemName: self.settingsViewModel.settingsData.settingsIcons[1][index])
                                .imageScale(.large)
                                .frame(width: 40, height: 40)
                            
                            //button
                            Button(self.settingsViewModel.settingsData.settingsOptions[1][index]) {
                                self.alertTitle = self.settingsViewModel.settingsData.settingsOptions[1][index]
                                self.showAlert.toggle()
                            }
                            .foregroundColor(.red)
                            //alert shown after logout or delete account button pressed
                            .alert(isPresented: self.$showAlert) {
                                Alert(
                                    title: Text("\(self.alertTitle)?"),
                                    message: Text("Please confirm your action"),
                                    primaryButton: .cancel(),
                                    secondaryButton: .destructive(Text(self.alertTitle), action: {
                                        self.logoutOrDelete(actionName: self.alertTitle)
                                    })
                                )
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Settings")
            .environment(\.horizontalSizeClass, .regular)
            //alert shown after delete account api call completes
            .alert(isPresented: $settingsViewModel.showUserDeleteAlert) {
                Alert(
                    title: Text(self.settingsViewModel.alertTitle),
                    message: Text(self.settingsViewModel.deleteAccountResponseData.message ?? ""),
                    dismissButton: .default(Text("Okay")) {
                        self.settingsViewModel.logout()
                    })
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
