//
//  Settings.swift
//  Created on 20/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct Settings: View {
    var settingsModel = SettingsModel()
    //Alert used for logout and delete action, to confirm user's action before proceeding.
    @State var showAlert = false
    @State var alertTitle = ""
    
    var body: some View {
        NavigationView {
            Form {
                //Top Space
                Section { EmptyView() }
                
                //Section 1 of settings : about, feedback, and change password
                Section {
                    ForEach(0 ..< settingsModel.settingsOptions[0].count, id: \.self) { index in
                        NavigationLink(destination: Text("Section 1 setting")) {
                            //Setting list cell
                            HStack {
                                //icon image
                                Image(systemName: self.settingsModel.settingsIcons[0][index])
                                    .imageScale(.large)
                                    .frame(width: 40, height: 40)
                                
                                //text
                                Text(self.settingsModel.settingsOptions[0][index])
                            }
                        }
                    }
                }
                
                //Section 2 of settings : logout, and delete account
                Section {
                    ForEach(0 ..< settingsModel.settingsOptions[1].count, id: \.self) { index in
                        //setting list cell
                        HStack {
                            //icon image
                            Image(systemName: self.settingsModel.settingsIcons[1][index])
                                .imageScale(.large)
                                .frame(width: 40, height: 40)
                            
                            //button
                            Button(self.settingsModel.settingsOptions[1][index]) {
                                self.alertTitle = self.settingsModel.settingsOptions[1][index]
                                self.showAlert.toggle()
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationBarTitle("Settings")
            .environment(\.horizontalSizeClass, .regular)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("\(self.alertTitle)?"),
                    message: Text("Please confirm your action"),
                    primaryButton: .cancel(),
                    secondaryButton: .destructive(Text(self.alertTitle), action: {
                        //add code
                    }))
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
