//
//  AddTask.swift
//  Created on 01/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct AddTask: View {
    @State var text = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: DesignConstants.Spacing.bigSpacing) {
                TextField("Task Description", text: $text)
                    .textFieldStyle(RoundFilledTextFieldStyle())
                
                Button("Add") {
                }
                .buttonStyle(BigBoldButtonStyle())
                
                Spacer()
            }
            .modifier(AllPadding())
            .navigationBarTitle("Add Task")
            .navigationBarItems(trailing: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
