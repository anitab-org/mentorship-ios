//
//  RequestModel.swift
//  Created on 24/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

struct RequestsList: Codable {
    let sent: RequestStructures?
    let received: RequestStructures?
    
    struct RequestStructures: Codable {
        let accepted: [RequestStructure]?
        let rejected: [RequestStructure]?
        let completed: [RequestStructure]?
        let cancelled: [RequestStructure]?
        let pending: [RequestStructure]?
    }
}

struct RequestStructure: Codable, Identifiable {
    let id: Int?
    let mentor: Info?
    let mentee: Info?
    let endDate: Double?
    let notes: String?
    
    enum CodingKeys: String, CodingKey {
        case id, mentor, mentee, notes
        case endDate = "end_date"
    }
    
    //info struct for mentor/mentee information
    struct Info: Codable {
        let id: Int?
        let userName: String?
        let name: String?
        
        enum CodingKeys: String, CodingKey {
            case id, name
            case userName = "user_name"
        }
    }
}

struct RequestActionResponse: Codable {
    let message: String?
}
