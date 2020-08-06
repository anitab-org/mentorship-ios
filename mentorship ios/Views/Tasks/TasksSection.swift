//
//  TasksToDoSection.swift
//  Created on 01/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct TasksSection: View {
    let tasks: [TaskStructure]?
    //used to enable mark as complete for to do tasks only.
    var isToDoSection: Bool = false
    var navToTaskComments = false
    var markAsCompleteAction: (TaskStructure) -> Void = { _ in }
    
    var iconName: String {
        if isToDoSection {
            return ImageNameConstants.SFSymbolConstants.taskToDo
        } else {
            return ImageNameConstants.SFSymbolConstants.taskDone
        }
    }
    
    var taskText: LocalizedStringKey {
        if isToDoSection {
            return LocalizableStringConstants.tasksToDo
        } else {
            return LocalizableStringConstants.tasksDone
        }
    }
    
    func taskCell(task: TaskStructure) -> some View {
        //Main HStack, shows icon and task
        HStack {
            Image(systemName: self.iconName)
                .foregroundColor(DesignConstants.Colors.defaultIndigoColor)
                .padding(.trailing, DesignConstants.Padding.insetListCellFrameExpansion)
            
            Text(task.description ?? "-")
                .font(.subheadline)
        }
        .padding(DesignConstants.Padding.insetListCellFrameExpansion)
            //context menu used to show and enable actions (eg. mark as complete)
            .contextMenu {
                if self.isToDoSection && navToTaskComments {
                    Button(LocalizableStringConstants.markComplete) { self.markAsCompleteAction(task) }
                }
        }
    }
    
    var body: some View {
        Section(header: Text(taskText).font(.headline)) {
            ForEach(tasks ?? []) { task in
                if self.navToTaskComments {
                    //Tapping leads to task comments page
                    NavigationLink(
                        destination: TaskComments(taskID: task.id ?? -1, taskName: task.description ?? "")
                    ) {
                        self.taskCell(task: task)
                    }
                } else {
                    self.taskCell(task: task)
                }
            }
        }
    }
}
