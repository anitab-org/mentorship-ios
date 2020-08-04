//
//  TaskModel.swift
//  Created on 05/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

struct TaskStructure: Codable, Identifiable, Equatable {
    let id: Int?
    let description: String?
    let isDone: Bool?
    let createdAt: Double?
    let completedAt: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, description
        case isDone = "is_done"
        case createdAt = "created_at"
        case completedAt = "completed_at"
    }
}
