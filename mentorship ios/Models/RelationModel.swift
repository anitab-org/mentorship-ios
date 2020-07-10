//
//  RelationModel.swift
//  Created on 02/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

class RelationModel {
    
    // MARK: - Variables
    let currentRelation = HomeModel.HomeResponseData.RequestStructure(id: 0, actionUserID: 0, mentor: nil, mentee: nil, acceptDate: 0, startDate: 0, endDate: 0, notes: "")
    
    let tasks = [TaskStructure]()
    
    let task = TaskStructure(id: 0, description: "", isDone: false, createdAt: 0, completedAt: 0)
    
    // MARK: - Structures
    struct ResponseData: Decodable {
        let message: String?
    }
    
    struct AddTaskData: Encodable {
        var description: String
    }
}
