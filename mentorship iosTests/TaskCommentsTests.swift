//
//  TaskCommentsTests.swift
//  Created on 30/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import XCTest
@testable import mentorship_ios

class TaskCommentsTests: XCTestCase {
    // custom urlsession for mock network calls
    var urlSession: URLSession!

    override func setUpWithError() throws {
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }

    override func tearDownWithError() throws {
        urlSession = nil
        super.tearDown()
    }

    // MARK: - Service Tests
    
    func testFetchComments() throws {
        let taskCommentsService: TaskCommentsService = TaskCommentsAPI(urlSession: urlSession)
        
        // Set mock json and data
        let mockJSON: [TaskCommentsModel.TaskCommentsResponse] = [
        .init(id: 0, userID: nil, creationDate: nil, comment: "Task 1"),
        .init(id: 1, userID: nil, creationDate: nil, comment: nil)
        ]
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data from mock handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        // Expectation
        let expectation = XCTestExpectation(description: "response")
        taskCommentsService.fetchTaskComments(reqID: 0, taskID: 0) { resp in
            XCTAssertEqual(resp.count, 2)
            XCTAssertEqual(resp[0].comment, mockJSON[0].comment)
            XCTAssertEqual(resp[1].id, mockJSON[1].id)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testPostTaskComment() throws {
        let taskCommentsService: TaskCommentsService = TaskCommentsAPI(urlSession: urlSession)
        
        // Set mock json and data
        let mockJSON = TaskCommentsModel.MessageResponse(message: "test", success: false)
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data from mock handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        // Expectation
        let expectation = XCTestExpectation(description: "response")
        taskCommentsService.postTaskComment(reqID: 0, taskID: 0, commentData: .init(comment: "comment")) { resp in
            XCTAssertEqual(resp.message, mockJSON.message)
            XCTAssertEqual(resp.success, false)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testReportTaskComment() throws {
        let taskCommentsService: TaskCommentsService = TaskCommentsAPI(urlSession: urlSession)
        
        // Set mock json and data
        let mockJSON = TaskCommentsModel.MessageResponse(message: "test", success: true)
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data from mock handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        // Expectation
        let expectation = XCTestExpectation(description: "response")
        taskCommentsService.reportComment(reqID: 0, taskID: 0, commentID: 0) { resp in
            XCTAssertEqual(resp.message, mockJSON.message)
            XCTAssertEqual(resp.success, true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: - View Model Tests
    
    func testCommentsMoreThanLimit() {
        let taskCommentsVM = TaskCommentsViewModel()

        // MARK: - 1. Comment is empty right now. Limit should not be crossed.
        XCTAssertEqual(taskCommentsVM.commentsMoreThanLimit, false)
        
        // MARK: - 2. Number of comments equal to limit. Limit should not be crossed.
        for _ in 1 ... taskCommentsVM.latestCommentsLimit {
            taskCommentsVM.taskCommentsResponse.append(.init(id: 0, userID: 0, creationDate: 0, comment: ""))
        }
        XCTAssertEqual(taskCommentsVM.commentsMoreThanLimit, false)
        
        // MARK: - 3. Add one more comment. Limit should get crossed. State should become true
        taskCommentsVM.taskCommentsResponse.append(.init(id: 0, userID: 0, creationDate: 0, comment: ""))
        XCTAssertEqual(taskCommentsVM.commentsMoreThanLimit, true)
    }
    
    func testCommentsToShow() {
        let taskCommentsVM = TaskCommentsViewModel()
        
        // MARK: - 1. Number of comments less than set limit. All comments should be shown.
        for index in 1 ... taskCommentsVM.latestCommentsLimit - 1 {
            taskCommentsVM.taskCommentsResponse.append(.init(id: index, userID: 0, creationDate: 0, comment: ""))
        }
        XCTAssertEqual(taskCommentsVM.commentsToShow.count, taskCommentsVM.taskCommentsResponse.count)
        XCTAssertEqual(taskCommentsVM.commentsToShow.first?.id, 1)
        XCTAssertEqual(taskCommentsVM.commentsToShow.last?.id, taskCommentsVM.commentsToShow.count)
        
        // MARK: - 2. Number of comments equal to set limit. All comments should be shown.
        taskCommentsVM.taskCommentsResponse.append(.init(id: 0, userID: 0, creationDate: 0, comment: ""))
        XCTAssertEqual(taskCommentsVM.commentsToShow.count, taskCommentsVM.taskCommentsResponse.count)
        
        // MARK: - 3. Number of comment more than set limit. Limit number of comments should be shown.
        taskCommentsVM.taskCommentsResponse.append(.init(id: 0, userID: 0, creationDate: 0, comment: ""))
        XCTAssertNotEqual(taskCommentsVM.commentsToShow.count, taskCommentsVM.taskCommentsResponse.count)
        XCTAssertEqual(taskCommentsVM.commentsToShow.count, taskCommentsVM.latestCommentsLimit)
        
        // MARK: - 4. Number of comments more than set limit for latest comments. However, show earlier is true. All should be shown.
        taskCommentsVM.showingEarlier = true
        XCTAssertEqual(taskCommentsVM.commentsToShow.count, taskCommentsVM.taskCommentsResponse.count)
    }
    
    func testSendButtonDisabledState() {
        let taskCommentsVM = TaskCommentsViewModel()
        
        // MARK: - 1. Comment is empty right now. Button should be disabled.
        XCTAssertEqual(taskCommentsVM.sendButtonDisabled, true)
        
        // MARK: - 2. Comment not empty. Button should be enabled.
        taskCommentsVM.newComment.comment = "test"
        XCTAssertEqual(taskCommentsVM.sendButtonDisabled, false)
    }
    
    func testGetAuthorName() {
        let taskCommentsVM = TaskCommentsViewModel()

        // ID same as user. Should return "You"
        XCTAssertEqual(taskCommentsVM.getCommentAuthorName(authorID: 5, userID: 5), "You")
        
        // ID different that user. Should return name of member
        taskCommentsVM.reqName = "testName"
        XCTAssertEqual(taskCommentsVM.getCommentAuthorName(authorID: 5, userID: 6), "testName")
    }

}
