//
//  RelationModel.swift
//  Created on 02/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

class RelationModel {
    
    // MARK: - Variables
    let currentRelation = RequestStructure(id: 0, mentor: nil, mentee: nil, endDate: 0, notes: "")
    
    let tasks = [TaskStructure]()
    
    let task = TaskStructure(id: 0, description: "", isDone: false, createdAt: 0, completedAt: 0)
    
    // MARK: - Structures
    struct ResponseData: Encodable {
        let message: String?
        let success: Bool
    }
    
    struct AddTaskData: Encodable {
        var description: String
    }
}

// MARK: API

extension RequestStructure {
    func update(viewModel: RelationViewModel) {
        viewModel.currentRelation = self
        //if current relation invalid, delete all tasks and return
        if self.id == nil {
            viewModel.toDoTasks.removeAll()
            viewModel.doneTasks.removeAll()
        }
    }
}

extension RelationModel.ResponseData {
    func update(viewModel: RelationViewModel) {
        viewModel.responseData = self
    }
}

extension TaskStructure {
    func update(viewModel: RelationViewModel) {
        if self.isDone ?? false {
            viewModel.doneTasks.append(self)
        } else {
            viewModel.toDoTasks.append(self)
        }
    }
}
