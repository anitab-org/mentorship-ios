//
//  AddTask.swift
//  Created on 01/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct AddTask: View {
    var relationService: RelationService = RelationAPI()
    @ObservedObject var relationViewModel: RelationViewModel
    @Environment(\.presentationMode) var presentationMode
    
    // use service to add task
    func addTask() {
        guard let relationID = self.relationViewModel.currentRelation.id else { return }
        self.relationService.addNewTask(newTask: self.relationViewModel.newTask, relationID: relationID) { response in
            // if task added successfully, dismiss sheet and refresh tasks
            if response.success {
                self.relationViewModel.addTask.toggle()
                self.relationService.fetchTasks(id: relationID) { (tasks, success) in
                    self.relationViewModel.handleFetchedTasks(tasks: tasks, success: success)
                }
            }
            // else show error message
            else {
                response.update(viewModel: self.relationViewModel)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: DesignConstants.Spacing.bigSpacing) {
                //new task description text field
                TextField("Task Description", text: $relationViewModel.newTask.description)
                    .textFieldStyle(RoundFilledTextFieldStyle())
                
                //add task button
                Button("Add") {
                    self.addTask()
                }
                .buttonStyle(BigBoldButtonStyle())
                .disabled(relationViewModel.addTaskDisabled)
                .opacity(relationViewModel.addTaskDisabled ? DesignConstants.Opacity.disabledViewOpacity : 1)
                
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
                // reset the new task description and error message desc to ""
                self.relationViewModel.resetDataForAddTaskScreen()
            }
        }
    }
}
