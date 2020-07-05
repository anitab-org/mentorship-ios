//
//  Relation.swift
//  Created on 30/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct Relation: View {
    //sample data
    @ObservedObject var sampleData = HomeViewModel()
    @State var showAlert = false
    @State var addTask  = false
    @State var newTaskDesc = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    //Top detail view
                    VStack {
                        //mentor/mentee and end date
                        HStack {
                            Text("Vatsal").font(.title).fontWeight(.heavy)
                            Spacer()
                            Text("Ends on: Aug 24, 2020").font(.callout)
                        }
                        .foregroundColor(DesignConstants.Colors.subtitleText)
                        
                        //divider
                        Divider()
                            .background(DesignConstants.Colors.defaultIndigoColor)
                    }
                    .listRowBackground(DesignConstants.Colors.formBackgroundColor)
                    
                    //Tasks To Do List section
                    TasksToDoSection(tasksToDo: sampleData.homeResponseData.tasksToDo) {
                        self.showAlert.toggle()
                    }
                    
                    //Tasks Done List section
                    TasksDoneSection(tasksDone: sampleData.homeResponseData.tasksDone)
                }
            }
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Current Relation")
            .navigationBarItems(trailing: Button("Add Task") {
                self.addTask.toggle()
            })
            .sheet(isPresented: $addTask) {
                AddTask()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Mark as completed?"),
                    primaryButton: .cancel(),
                    secondaryButton: .default(Text(LocalizableStringConstants.confirm)))
            }
        }
    }
}

struct Relation_Previews: PreviewProvider {
    static var previews: some View {
        Relation()
    }
}
