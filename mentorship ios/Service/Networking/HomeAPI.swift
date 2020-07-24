//
//  HomeAPI.swift
//  Created on 22/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

class HomeAPI: HomeService {
    private var cancellable: AnyCancellable?
    // local variable. Helpful in state preservation (used in catch operator)
    var homeNetworkModel = HomeNetworkModel(asMentor: nil, asMentee: nil, tasksToDo: nil, tasksDone: nil)
    
    func fetchDashboard(completion: @escaping (HomeModel.HomeResponseData) -> Void) {
        //get auth token
        guard let token = try? KeychainManager.getToken() else {
            return
        }
        
        //api call
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.home, token: token)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.homeNetworkModel) }
            .sink { home in
                // update home network model local variable.
                self.homeNetworkModel = home
                let homeResponse = HomeModel.HomeResponseData(
                    asMentor: home.asMentor,
                    asMentee: home.asMentee,
                    tasksToDo: home.tasksToDo,
                    tasksDone: home.tasksDone)
                // completion handler
                completion(homeResponse)
        }
    }
    
    struct HomeNetworkModel: Decodable {
        let asMentor: RequestsList?
        let asMentee: RequestsList?
        
        let tasksToDo: [TaskStructure]?
        let tasksDone: [TaskStructure]?
        
        enum CodingKeys: String, CodingKey {
            case asMentor = "as_mentor"
            case asMentee = "as_mentee"
            case tasksToDo = "tasks_todo"
            case tasksDone = "tasks_done"
        }
    }
}
