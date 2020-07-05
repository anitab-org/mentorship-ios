//
//  TasksDoneList.swift
//  Created on 30/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct TasksDoneSection<T: TaskStructureProperties>: View {
    var tasksDone: [T]?
    
    var body: some View {
        //Tasks Done list
        Section(header: Text(LocalizableStringConstants.tasksDone).font(.headline)) {
            ForEach(tasksDone ?? []) { task in
                HStack {
                    Image(systemName: ImageNameConstants.SFSymbolConstants.taskDone)
                        .foregroundColor(DesignConstants.Colors.defaultIndigoColor)
                        .padding(.trailing, DesignConstants.Padding.insetListCellFrameExpansion)

                    Text(task.description ?? "-")
                        .font(.subheadline)
                }
            }
        }
    }
}
