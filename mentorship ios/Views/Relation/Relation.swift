//
//  Relation.swift
//  Created on 30/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct Relation: View {
    var relationService: RelationService = RelationAPI()
    @ObservedObject var relationViewModel = RelationViewModel()
    @ObservedObject var taskCommentsViewModel = TaskCommentsViewModel()
    @State var showAlert = false
    
    var endDate: Date {
        return Date(timeIntervalSince1970: relationViewModel.currentRelation.endDate ?? 0)
    }
    
    // use service to fetch relation and tasks
    func fetchRelationAndTasks() {
        // For first time load set inactivity to true
        self.relationViewModel.inActivity = self.relationViewModel.firstTimeLoad
        
        // make api call to fetch current relation
        self.relationService.fetchCurrentRelation { response in
            // map repsonse to relation view model
            response.update(viewModel: self.relationViewModel)
            self.relationViewModel.inActivity = false
            self.relationViewModel.firstTimeLoad = false
            // update task comments vm
            self.taskCommentsViewModel.reqName = self.relationViewModel.personName
            //chain api call. get current tasks using id from current relation
            if let currentID = response.id {
                // update task comments vm
                self.taskCommentsViewModel.reqID = currentID
                // make api call
                self.relationService.fetchTasks(id: currentID) { tasks, success in
                    self.relationViewModel.handleFetchedTasks(tasks: tasks, success: success)
                }
            }
        }
    }
    
    // use relation service and mark task as complete
    func markAsComplete() {
        // get ids and make network request
        let taskTapped = RelationViewModel.taskTapped
        guard let taskID = taskTapped.id else { return }
        guard let reqID = self.relationViewModel.currentRelation.id else { return }
        // network request
        self.relationService.markAsComplete(taskID: taskID, relationID: reqID) { response in
            // map response
            response.update(viewModel: self.relationViewModel)
            // if success, update data
            if response.success {
                if let index = self.relationViewModel.toDoTasks.firstIndex(of: taskTapped) {
                    self.relationViewModel.toDoTasks.remove(at: index)
                    self.relationViewModel.doneTasks.append(taskTapped)
                }
            }
            // else, show error message
            else {
                self.relationViewModel.showAlert = true
                self.relationViewModel.alertMessage = LocalizableStringConstants.operationFail
            }
        }
    }

    @ViewBuilder func trailingNavigationBarItem() -> some View {
        if let id = relationViewModel.currentRelation.id, id != 0 {
            Button(LocalizableStringConstants.addTask) {
                self.relationViewModel.addTask.toggle()
            }
        } 
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    //Top detail view
                    VStack(alignment: .leading, spacing: DesignConstants.Form.Spacing.minimalSpacing) {
                        //mentor/mentee name and end date
                        HStack {
                            Text(relationViewModel.personName).font(.title).fontWeight(.heavy)
                            Spacer()
                            Text(relationViewModel.personType).font(.title)
                        }
                        .foregroundColor(DesignConstants.Colors.subtitleText)
                        
                        Text("Ends On: \(DesignConstants.DateFormat.mediumDate.string(from: endDate))")
                            .font(.callout)
                        
                        //divider, adds a line below name and date
                        Divider()
                            .background(DesignConstants.Colors.defaultIndigoColor)
                    }
                    .listRowBackground(DesignConstants.Colors.formBackgroundColor)
                    
                    //Tasks To Do List section
                    TasksSection(tasks: relationViewModel.toDoTasks, isToDoSection: true, navToTaskComments: true) { task in
                        //set tapped task
                        RelationViewModel.taskTapped = task
                        //show alert for marking as complete confirmation
                        self.showAlert.toggle()
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text(LocalizableStringConstants.markComplete),
                            primaryButton: .cancel(),
                            secondaryButton: .default(Text(LocalizableStringConstants.confirm)) {
                                self.markAsComplete()
                            })
                    }
                    
                    //Tasks Done List section
                    TasksSection(tasks: relationViewModel.doneTasks, navToTaskComments: true)
                }
                
                //show activity spinner if in activity
                if relationViewModel.inActivity {
                    ActivityIndicator(isAnimating: $relationViewModel.inActivity, style: .medium)
                }
            }
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Current Relation")
            .navigationBarItems(trailing: trailingNavigationBarItem())
            .sheet(isPresented: $relationViewModel.addTask) {
                AddTask(relationViewModel: self.relationViewModel)
            }
            .alert(isPresented: $relationViewModel.showErrorAlert) {
                Alert(
                    title: Text(self.relationViewModel.alertTitle),
                    message: Text(self.relationViewModel.alertMessage),
                    dismissButton: .default(Text(LocalizableStringConstants.okay)))
            }
            .onAppear {
                self.fetchRelationAndTasks()
            }
            .environmentObject(self.taskCommentsViewModel)
        }
    }
}

struct Relation_Previews: PreviewProvider {
    static var previews: some View {
        Relation()
    }
}
