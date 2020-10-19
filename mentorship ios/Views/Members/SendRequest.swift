//
//  SendRequest.swift
//  Created on 09/06/20.
//  Created for AnitaB.org Mentorship-iOS
//

import SwiftUI
import Combine

struct SendRequest: View {
    var membersService: MembersService = MembersAPI()
    @ObservedObject var membersViewModel = MembersViewModel()
    var memberID: Int
    var memberName: String
    @State private var pickerSelection = 1
    @State private var endDate = Date()
    @State private var notes = ""
    @State private var offsetValue: CGFloat = 0
    @Environment(\.presentationMode) var presentationMode

    // use service to send request
    func sendRequest() {
        // set inactivity to true
        self.membersViewModel.inActivity = true
        
        // set parameters
        let myID = ProfileViewModel().getProfile().id
        let endDateTimestamp = self.endDate.timeIntervalSince1970
        var menteeID = myID
        var mentorID = memberID
        if pickerSelection == 2 {
            menteeID = memberID
            mentorID = myID
        }
        // make request
        membersService.sendRequest(menteeID: menteeID, mentorID: mentorID, endDate: endDateTimestamp, notes: notes) { response in
            self.membersViewModel.inActivity = false
            self.membersViewModel.sendRequestResponseData = response
        }
    }

    var body: some View {
        NavigationView {
            List {
                //heading
                Section(header: Text("To \(memberName)").font(.title).fontWeight(.heavy)) {
                    EmptyView()
                }

                //settings
                Section {
                    Picker(selection: $pickerSelection, label: Text("My Role")) {
                        Text(LocalizableStringConstants.mentee).tag(1)
                        Text(LocalizableStringConstants.mentor).tag(2)
                    }

                    DatePicker(selection: $endDate, displayedComponents: .date) {
                        Text(LocalizableStringConstants.endDate)
                    }

                    TextField(LocalizableStringConstants.notes, text: $notes)
                }
              //  .padding(.vertical, DesignConstants.Padding.listCellFrameExpansion)

                //send button
                Section {
                    Button(action: sendRequest) {
                        Text(LocalizableStringConstants.send)
                    }
                }

                //Activity indicator or error text
                if membersViewModel.inActivity || !(membersViewModel.sendRequestResponseData.message ?? "").isEmpty {
                    Section {
                        if membersViewModel.inActivity {
                            ActivityIndicator(isAnimating: $membersViewModel.inActivity, style: .medium)
                        } else if !membersViewModel.sendRequestResponseData.success {
                            Text(membersViewModel.sendRequestResponseData.message ?? "")
                                .modifier(ErrorText())
                        }
                    }
                    .listRowBackground(DesignConstants.Colors.formBackgroundColor)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(LocalizableStringConstants.relationRequest)
            .navigationBarItems(leading: Button(LocalizableStringConstants.cancel, action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
            .alert(isPresented: $membersViewModel.sendRequestResponseData.success) {
                Alert(
                    title: Text(LocalizableStringConstants.success),
                    message: Text(membersViewModel.sendRequestResponseData.message ?? "Mentorship relation was sent successfully."),
                    dismissButton: .cancel(Text(LocalizableStringConstants.okay), action: {
                        self.presentationMode.wrappedValue.dismiss()
                        self.membersViewModel.sendRequestResponseData.success = true
                    })
                )
            }
        }
    }
}

struct SendRequest_Previews: PreviewProvider {
    static var previews: some View {
        SendRequest(memberID: 0, memberName: "demo name")
    }
}
