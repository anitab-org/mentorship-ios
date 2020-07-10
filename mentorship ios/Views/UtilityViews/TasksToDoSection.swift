//
//  TasksToDoSection.swift
//  Created on 01/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct TasksToDoSection: View {
    var tasksToDo: [TaskStructure]?
    var onTapAction: (TaskStructure) -> Void
    
    //intialiser for view
    init(tasksToDo: [TaskStructure]?, onTapAction: @escaping (TaskStructure) -> Void = { _ in }) {
        self.tasksToDo = tasksToDo ?? []
        self.onTapAction = onTapAction
    }

    var body: some View {
        Section(header: Text(LocalizableStringConstants.tasksToDo).font(.headline)) {
            ForEach(tasksToDo ?? []) { task in
                HStack {
                    Image(systemName: ImageNameConstants.SFSymbolConstants.taskToDo)
                        .foregroundColor(DesignConstants.Colors.defaultIndigoColor)
                        .padding(.trailing, DesignConstants.Padding.insetListCellFrameExpansion)

                    Text(task.description ?? "-")
                        .font(.subheadline)
                }
                .onTapGesture {
                    //run tap action closure
                    self.onTapAction(task)
                }
            }
        }
    }
}
