//
//  RelationViewModel.swift
//  Created on 02/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI
import Combine

class RelationViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var currentRelation = RelationModel().currentRelation
    @Published var responseData = RelationModel.ResponseData(message: "", success: false)
    var tasks = RelationModel().tasks
    var firstTimeLoad = true
    @Published var newTask = RelationModel.AddTaskData(description: "")
    @Published var toDoTasks = RelationModel().tasks
    @Published var doneTasks = RelationModel().tasks
    @Published var inActivity = false
    @Published var addTask = false
    @Published var showAlert = false
    @Published var showErrorAlert = false
    @Published var alertTitle = LocalizableStringConstants.failure
    @Published var alertMessage = LocalizedStringKey("")
    static var taskTapped = RelationModel().task
    private var cancellable: AnyCancellable?
    
    var addTaskDisabled: Bool {
        return newTask.description.isEmpty
    }
    
    var personName: String {
        // User profile
        let userProfile = ProfileViewModel().getProfile()
        //match users name with mentee name.
        //if different, return mentee's name. Else, return mentor's name
        //Logic: Person with different name is in relation with us.
        if currentRelation.mentee?.name != userProfile.name {
            return currentRelation.mentee?.name ?? ""
        } else {
            return currentRelation.mentor?.name ?? ""
        }
    }
    
    var personType: LocalizedStringKey {
        // User profile
        let userProfile = ProfileViewModel().getProfile()
        // Person with different name is in relation with us. Hence deduce person type.
        if currentRelation.mentee?.name != userProfile.name {
            return LocalizableStringConstants.mentee
        } else {
            return LocalizableStringConstants.mentor
        }
    }
    
    // MARK: - Functions
    
    // resets values in add task screen. Used in onAppear modifier in the view
    func resetDataForAddTaskScreen() {
        newTask.description = ""
        responseData.message = ""
    }
    
    func handleFetchedTasks(tasks: [TaskStructure], success: Bool) {
        if success {
            doneTasks.removeAll()
            toDoTasks.removeAll()
            for task in tasks {
                task.update(viewModel: self)
            }
        } else {
            showErrorAlert = true
            alertMessage = LocalizableStringConstants.operationFail
        }
    }
}
