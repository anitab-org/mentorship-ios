//
//  TaskProperties.swift
//  Created on 30/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

//protocol used for TaskStructure propoerties
//helps in reusing TasksList in home screen and relation screen

protocol TaskStructureProperties: Identifiable {
    var id: Int? { get }
    var description: String? { get }
    var createdAt: Double? { get }
    var completedAt: Double? { get }
}
