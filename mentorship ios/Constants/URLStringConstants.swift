//
//  URLConstants.swift
//  Created on 05/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

let baseURL: String = "https://mentorship-backend-temp.herokuapp.com/"
///only for local backend testing
//let baseURL: String = "http://127.0.0.1:5000/"

struct URLStringConstants {
    struct Users {
        static let login: String = baseURL + "login"
        static let signUp: String = baseURL + "register"
        static func members(page: Int, perPage: Int, search: String) -> String {
            return baseURL + "users?page=\(page)&per_page=\(perPage)&search=\(search)"
        }
        static let home: String = baseURL + "dashboard"
        static let user: String = baseURL + "user"
        static let changePassword: String = baseURL + "user/change_password"
    }

    struct MentorshipRelation {
        static let sendRequest: String = baseURL + "mentorship_relation/send_request"
        static let currentRelation: String = baseURL + "mentorship_relations/current"
        static func getCurrentTasks(id: Int) -> String {
            return baseURL + "mentorship_relation/\(id)/tasks"
        }
        static func markAsComplete(reqID: Int, taskID: Int) -> String {
            return baseURL + "mentorship_relation/\(reqID)/task/\(taskID)/complete"
        }
        static func addNewTask(reqID: Int) -> String {
            return baseURL + "mentorship_relation/\(reqID)/task"
        }
        static func getTaskComments(reqID: Int, taskID: Int) -> String {
            return baseURL + "mentorship_relation/\(reqID)/task/\(taskID)/comments"
        }
        static func postTaskComment(reqID: Int, taskID: Int) -> String {
            return baseURL + "mentorship_relation/\(reqID)/task/\(taskID)/comment"
        }
        static func reportTaskComment(reqID: Int, taskID: Int, commentID: Int) -> String {
            return baseURL + "mentorship_relation/\(reqID)/task/\(taskID)/comment/\(commentID)/report"
        }
        static func accept(reqID: Int) -> String {
            return baseURL + "mentorship_relation/\(reqID)/accept"
        }
        static func reject(reqID: Int) -> String {
            return baseURL + "mentorship_relation/\(reqID)/reject"
        }
        static func cancel(reqID: Int) -> String {
            return baseURL + "mentorship_relation/\(reqID)/cancel"
        }
        static func delete(reqID: Int) -> String {
            return baseURL + "mentorship_relation/\(reqID)"
        }
    }
    
    struct WebsiteURLs {
        static let privacyPolicy = "https://anitab.org/privacy-policy/"
        static let termsOfUse = "https://anitab.org/terms-of-use/"
    }
}
