//
//  SendRequest.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 09/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI
import Combine

struct SendRequest: View {
    var name: String
    @State private var pickerSelection = 1
    @State private var endDate = Date()
    @State private var notesText = ""
    @State private var offsetValue: CGFloat = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                //heading
                Section(header: Text("To \(name)").font(.title).fontWeight(.heavy)) {
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

                    TextField(LocalizableStringConstants.notes, text: $notesText)
                }
                .padding(.vertical, DesignConstants.Padding.listCellFrameExpansion)

                //send button
                Section {
                    Button(action: {}) {
                        Text(LocalizableStringConstants.send)
                    }
                }
            }
            .navigationBarTitle(LocalizableStringConstants.relationRequest)
            .navigationBarItems(leading: Button(LocalizableStringConstants.cancel, action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
    }
}

struct SendRequest_Previews: PreviewProvider {
    static var previews: some View {
        SendRequest(name: "Name")
    }
}
