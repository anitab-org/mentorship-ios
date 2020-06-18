//
//  HomeModel.swift
//  Created on 12/06/20.
//  Created for AnitaB.org Mentorship-iOS
//

import SwiftUI
import Combine

final class HomeModel: ObservableObject {
    // MARK: - Variables
    @Published var homeResponseData = HomeResponseData(asMentor: nil, asMentee: nil, tasksToDo: nil, tasksDone: nil)
    @Published var relationsListData = RelationsListData()
    @Published var profileData = ProfileModel().profileData
    var profileModel = ProfileModel()
    var isLoading: Bool = false
    private var cancellable: AnyCancellable?

    // MARK: - Functions
    init() {
        //get auth token
        guard let token = try? KeychainManager.readKeychain() else {
            return
        }
        print(token)

        //used to express loading state in UI in home screen
        isLoading = true

        //parallel request for profile and home
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.home, token: token)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.homeResponseData) }
            .combineLatest(
                NetworkManager.callAPI(urlString: URLStringConstants.Users.getProfile, token: token, cachePolicy: .returnCacheDataElseLoad)
                    .receive(on: RunLoop.main)
                    .catch { _ in Just(self.profileModel.profileData) }
            )
            .sink { home, profile in
                self.profileModel.saveProfile(profile: profile)
                self.profileData = profile
                self.updateCount(homeData: home)
                self.homeResponseData = home
                self.isLoading = false
            }
    }

    func updateCount(homeData: HomeResponseData) {
        var pendingCount = homeData.asMentee?.sent?.pending?.count ?? 0
        pendingCount += homeData.asMentee?.received?.pending?.count ?? 0
        pendingCount += homeData.asMentor?.sent?.pending?.count ?? 0
        pendingCount += homeData.asMentor?.received?.pending?.count ?? 0

        var acceptedCount = homeData.asMentee?.sent?.accepted?.count ?? 0
        acceptedCount += homeData.asMentee?.received?.accepted?.count ?? 0
        acceptedCount += homeData.asMentor?.sent?.accepted?.count ?? 0
        acceptedCount += homeData.asMentor?.received?.accepted?.count ?? 0

        var rejectedCount = homeData.asMentee?.sent?.rejected?.count ?? 0
        rejectedCount += homeData.asMentee?.received?.rejected?.count ?? 0
        rejectedCount += homeData.asMentor?.sent?.rejected?.count ?? 0
        rejectedCount += homeData.asMentor?.received?.rejected?.count ?? 0

        var cancelledCount = homeData.asMentee?.sent?.cancelled?.count ?? 0
        cancelledCount += homeData.asMentee?.received?.cancelled?.count ?? 0
        cancelledCount += homeData.asMentor?.sent?.cancelled?.count ?? 0
        cancelledCount += homeData.asMentor?.received?.cancelled?.count ?? 0

        var completedCount = homeData.asMentee?.sent?.completed?.count ?? 0
        completedCount += homeData.asMentee?.received?.completed?.count ?? 0
        completedCount += homeData.asMentor?.sent?.completed?.count ?? 0
        completedCount += homeData.asMentor?.received?.completed?.count ?? 0

        self.relationsListData.relationCount = [pendingCount, acceptedCount, rejectedCount, cancelledCount, completedCount]
    }

    func getSentDetailListData(userType: UserType, index: Int) -> [HomeModel.HomeResponseData.RequestStructure]? {
        if userType == .mentee {
            let data1 = homeResponseData.asMentee?.sent
            switch index {
            case 0: return data1?.pending
            case 1: return data1?.accepted
            case 2: return data1?.rejected
            case 3: return data1?.cancelled
            case 4: return data1?.completed
            default: return []
            }
        } else {
            let data1 = homeResponseData.asMentor?.sent
            switch index {
            case 0: return data1?.pending
            case 1: return data1?.accepted
            case 2: return data1?.rejected
            case 3: return data1?.cancelled
            case 4: return data1?.completed
            default: return []
            }
        }
    }

    func getReceivedDetailListData(userType: UserType, index: Int) -> [HomeModel.HomeResponseData.RequestStructure]? {
        if userType == .mentee {
            let data1 = homeResponseData.asMentee?.received
            switch index {
            case 0: return data1?.pending
            case 1: return data1?.accepted
            case 2: return data1?.rejected
            case 3: return data1?.cancelled
            case 4: return data1?.completed
            default: return []
            }
        } else {
            let data1 = homeResponseData.asMentor?.received
            switch index {
            case 0: return data1?.pending
            case 1: return data1?.accepted
            case 2: return data1?.rejected
            case 3: return data1?.cancelled
            case 4: return data1?.completed
            default: return []
            }
        }
    }

    // MARK: - Structures
    struct HomeResponseData: Decodable {
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

        //Nested structs

        struct RequestsList: Decodable {
            let sent: Sent?
            struct Sent: Decodable {
                let accepted: [RequestStructure]?
                let rejected: [RequestStructure]?
                let completed: [RequestStructure]?
                let cancelled: [RequestStructure]?
                let pending: [RequestStructure]?
            }
            let received: Received?
            struct Received: Decodable {
                let accepted: [RequestStructure]?
                let rejected: [RequestStructure]?
                let completed: [RequestStructure]?
                let cancelled: [RequestStructure]?
                let pending: [RequestStructure]?
            }
        }
        struct RequestStructure: Decodable, Identifiable {
            let id: Int?
            let actionUserID: Int?
            let mentor: Info?
            let mentee: Info?
            let acceptDate: Double?
            let startDate: Double?
            let endDate: Double?
            let notes: String?

            enum CodingKeys: String, CodingKey {
                case id, mentor, mentee, notes
                case actionUserID = "action_user_id"
                case acceptDate = "accept_date"
                case startDate = "start_date"
                case endDate = "end_date"
            }

            //info struct for mentor/mentee information
            struct Info: Decodable {
                let id: Int?
                let userName: String?

                enum CodingKeys: String, CodingKey {
                    case id
                    case userName = "user_name"
                }
            }
        }
        struct TaskStructure: Decodable, Identifiable {
            let id: Int?
            let description: String?
            let createdAt: Double?
            let completedAt: Double?

            enum CodingKeys: String, CodingKey {
                case id, description
                case createdAt = "created_at"
                case completedAt = "completed_at"
            }
        }
    }

    struct RelationsListData {
        let relationTitle = [
            "Pending",
            "Accepted",
            "Rejected",
            "Cancelled",
            "Completed"
        ]
        let relationImageName = [
            ImageNameConstants.SFSymbolConstants.pending,
            ImageNameConstants.SFSymbolConstants.accepted,
            ImageNameConstants.SFSymbolConstants.rejected,
            ImageNameConstants.SFSymbolConstants.cancelled,
            ImageNameConstants.SFSymbolConstants.completed
        ]
        let relationImageColor: [Color] = [
            DesignConstants.Colors.pending,
            DesignConstants.Colors.accepted,
            DesignConstants.Colors.rejected,
            DesignConstants.Colors.cancelled,
            DesignConstants.Colors.defaultIndigoColor
        ]
        var relationCount = [0, 0, 0, 0, 0]
    }

    enum UserType {
        case mentee, mentor
    }

}
