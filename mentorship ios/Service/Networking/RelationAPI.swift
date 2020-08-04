//
//  RelationAPI.swift
//  Created on 23/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

class RelationAPI: RelationService {
    private var cancellable: AnyCancellable?
    private var tasksCancellable: AnyCancellable?
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchCurrentRelation(completion: @escaping (RequestStructure) -> Void) {
        //get auth token
        guard let token = try? KeychainManager.getToken() else {
            return
        }
        
        //api call
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.MentorshipRelation.currentRelation, token: token, session: urlSession)
            .receive(on: RunLoop.main)
            .catch { _ in Just(RelationModel().currentRelation) }
            .sink {
                completion($0)
        }
    }
    
    func fetchTasks(id: Int, completion: @escaping ([TaskStructure], Bool) -> Void) {
        //get auth token
        guard let token = try? KeychainManager.getToken() else {
            return
        }
        
        // make api call
        tasksCancellable = NetworkManager.callAPI(urlString: URLStringConstants.MentorshipRelation.getCurrentTasks(id: id), token: token, session: urlSession)
            .receive(on: RunLoop.main)
            .catch { _ in Just(RelationModel().tasks) }
            .sink {
                let success = NetworkManager.responseCode == 200
                completion($0, success)
        }
    }
    
    //create newtask api call
    func addNewTask(newTask: RelationModel.AddTaskData, relationID: Int, completion: @escaping (RelationModel.ResponseData) -> Void) {
        //get auth token
        guard let token = try? KeychainManager.getToken() else {
            return
        }
        
        //prepare upload data
        guard let uploadData = try? JSONEncoder().encode(newTask) else {
            return
        }
        
        //api call
        cancellable = NetworkManager.callAPI(
            urlString: URLStringConstants.MentorshipRelation.addNewTask(reqID: relationID),
            httpMethod: "POST",
            uploadData: uploadData,
            token: token,
            session: urlSession)
            .receive(on: RunLoop.main)
            .catch { _ in Just(NetworkResponse(message: LocalizableStringConstants.networkErrorString)) }
            .sink {
                let success = NetworkManager.responseCode == 201
                let response = RelationModel.ResponseData(message: $0.message, success: success)
                completion(response)
        }
    }
    
    //mark task as complete api call
    func markAsComplete(taskID: Int, relationID: Int, completion: @escaping (RelationModel.ResponseData) -> Void) {
        //get auth token
        guard let token = try? KeychainManager.getToken() else {
            return
        }
        
        //api call
        cancellable = NetworkManager.callAPI(
            urlString: URLStringConstants.MentorshipRelation.markAsComplete(reqID: relationID, taskID: taskID),
            httpMethod: "PUT",
            token: token,
            session: urlSession)
            .receive(on: RunLoop.main)
            .catch { _ in Just(NetworkResponse(message: LocalizableStringConstants.networkErrorString)) }
            .sink {
                let success = NetworkManager.responseCode == 200
                let response = RelationModel.ResponseData(message: $0.message, success: success)
                completion(response)
        }
    }
    
    struct NetworkResponse: Decodable {
        let message: String?
    }
}
