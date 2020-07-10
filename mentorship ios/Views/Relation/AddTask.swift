//
//  AddTask.swift
//  Created on 01/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct AddTask: View {
    @ObservedObject var relationViewModel: RelationViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: DesignConstants.Spacing.bigSpacing) {
                //new task description text field
                TextField("Task Description", text: $relationViewModel.newTask.description)
                    .textFieldStyle(RoundFilledTextFieldStyle())
                
                //add task button
                Button("Add") {
                    self.relationViewModel.addNewTask()
                }
                .buttonStyle(BigBoldButtonStyle())
                
                //error message
                Text(self.relationViewModel.responseData.message ?? "")
                    .modifier(ErrorText())
                
                //spacer to shift things at top
                Spacer()
            }
            .modifier(AllPadding())
            .navigationBarTitle(LocalizableStringConstants.addTask)
            .navigationBarItems(trailing: Button(LocalizableStringConstants.cancel) {
                self.presentationMode.wrappedValue.dismiss()
            })
            .onAppear {
                self.relationViewModel.newTask.description = ""
            }
        }
    }
}
