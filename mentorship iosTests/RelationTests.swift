//
//  RelationTests.swift
//  Created on 26/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import XCTest
@testable import mentorship_ios

class RelationTests: XCTestCase {
    // custom urlsession for mock network calls
    var urlSession: URLSession!
    
    // MARK: - Setup and Tear Down

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
    
    // MARK: - Service tests
    
    func testGetCurrentRelationService() throws {
        // Service
        let relationService: RelationService = RelationAPI(urlSession: urlSession)
        
        // Set mock json and data
        let mockJSON = RequestStructure(id: 0, mentor: nil, mentee: nil, endDate: 100, notes: "notes")
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data form mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // Expectation. Used to test async code
        let expectation = XCTestExpectation(description: "response")
        
        relationService.fetchCurrentRelation { resp in
            XCTAssertEqual(resp.id, 0)
            XCTAssertEqual(resp.endDate, mockJSON.endDate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchTasksService() throws {
        // Service
        let relationService: RelationService = RelationAPI(urlSession: urlSession)
        
        // Set mock json and data
        let mockJSON = [TaskStructure(id: 0, description: "test task", isDone: true, createdAt: 0, completedAt: 0)]
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data form mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // Expectation. Used to test async code
        let expectation = XCTestExpectation(description: "response")
        
        relationService.fetchTasks(id: 0) { resp, success in
            // test count
            XCTAssertEqual(resp.count, 1)
            // test data. Use both methods - using literal, using mock json
            XCTAssertEqual(resp.first?.id, 0)
            XCTAssertEqual(resp.first?.description, mockJSON.first?.description)
            // test success
            XCTAssertEqual(success, true)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testAddNewTaskService() throws {
        // Service
        let relationService: RelationService = RelationAPI(urlSession: urlSession)
        
        // Set mock json and data
        let mockJSON = RelationModel.ResponseData(message: "test", success: true)
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data form mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // Expectation. Used to test async code
        let expectation = XCTestExpectation(description: "response")
        // Make request and test response
        relationService.addNewTask(newTask: RelationModel.AddTaskData(description: "test add task"), relationID: 0) { resp in
            XCTAssertEqual(resp.message, mockJSON.message)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testMarkTaskAsCompleteService() throws {
        // Service
        let relationService: RelationService = RelationAPI(urlSession: urlSession)
        
        // Set mock json and data
        let mockJSON = RelationModel.ResponseData(message: "test", success: true)
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data form mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // Expectation. Used to test async code
        let expectation = XCTestExpectation(description: "response")
        
        relationService.markAsComplete(taskID: 0, relationID: 0) { resp in
            XCTAssertEqual(resp.message, mockJSON.message)
            XCTAssertEqual(resp.success, true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: - RelationViewModel tests
    
    func testAddTaskDisabledIsTrue() {
        let relationVM = RelationViewModel()
        // new task description is empty, add task button should be disabled
        XCTAssertTrue(relationVM.addTaskDisabled)
    }
    
    func testAddTaskDisabledIsFalse() {
        let relationVM = RelationViewModel()
        // assign non empty value to new task description
        relationVM.newTask.description = "test"
        // add task must be allowed now (enabled)
        XCTAssertFalse(relationVM.addTaskDisabled)
    }
    
    func testResetDataForAddTaskScreen() {
        let relationVM = RelationViewModel()
        
        // set some values to response and new task description
        relationVM.newTask.description = "test"
        relationVM.responseData.message = "message"
        
        // reset
        relationVM.resetDataForAddTaskScreen()
        
        // Test
        XCTAssertEqual(relationVM.newTask.description.isEmpty, true)
        XCTAssertEqual(relationVM.responseData.message?.isEmpty, true)
    }
    
    func testPersonNameAndType() {
        let relationVM = RelationViewModel()
        
        // set names of user and other member in relation
        let userName = "User"
        let otherName = "RelationMemberName"
        
        // set sample user profile
        let sampleUserProfile = ProfileModel.ProfileData(id: 0, name: userName, email: "")
        ProfileViewModel().saveProfile(profile: sampleUserProfile)
        
        // set sample current relation
        let sampleRelation = RequestStructure(
            id: 0,
            mentor: RequestStructure.Info(id: 0, userName: "", name: userName),
            mentee: RequestStructure.Info(id: 1, userName: "", name: otherName),
            endDate: 0,
            notes: "")
        
        // make sample relation the current relation in view model
        relationVM.currentRelation = sampleRelation
        
        // Test. Person name should be equal to otherName
        XCTAssertEqual(relationVM.personName, otherName)
        // Test. Person type should be mentee.
        XCTAssertEqual(relationVM.personType, LocalizableStringConstants.mentee)
    }
    
    func testHandleFetchedTasks() {
        let relationVM = RelationViewModel()

        // set sample tasks
        let sampleTasks = [
            TaskStructure(id: 0, description: "", isDone: true, createdAt: 0, completedAt: 0),
            TaskStructure(id: 1, description: "", isDone: false, createdAt: 0, completedAt: 0),
            TaskStructure(id: 2, description: "", isDone: true, createdAt: 0, completedAt: 0)
        ]
        
        // Test. Handle sample tasks. Success = true.
        relationVM.handleFetchedTasks(tasks: sampleTasks, success: true)
        XCTAssertEqual(relationVM.toDoTasks.count, 1)
        XCTAssertEqual(relationVM.doneTasks.count, 2)
        XCTAssertEqual(relationVM.toDoTasks.first?.id, 1)
        XCTAssertEqual(relationVM.doneTasks.first?.id, 0)
        XCTAssertEqual(relationVM.doneTasks.last?.id, 2)
        
        // Test. Handle sample tasks. Success = false.
        relationVM.handleFetchedTasks(tasks: sampleTasks, success: false)
        XCTAssertEqual(relationVM.showErrorAlert, true)
        XCTAssertEqual(relationVM.alertMessage, LocalizableStringConstants.operationFail)
    }
    
    // MARK: - View Tests (Integration Tests)
    
    func testFetchRelationAndTasks() throws {
        // Service
        let relationService: RelationService = RelationAPI(urlSession: urlSession)
        // View Model
        let relationVM = RelationViewModel()
        // View
        let relationView = Relation(relationService: relationService, relationViewModel: relationVM)
        
        // Set mock json and data for current relation
        let mockRelation = RequestStructure(id: 1, mentor: nil, mentee: nil, endDate: 100, notes: "notes")
        let relationData = try JSONEncoder().encode(mockRelation)
        
        // Set mock json and data for tasks
        let mockTasks = [
            TaskStructure(id: 0, description: "", isDone: true, createdAt: 0, completedAt: 0),
            TaskStructure(id: 1, description: "", isDone: false, createdAt: 0, completedAt: 0),
            TaskStructure(id: 2, description: "", isDone: true, createdAt: 0, completedAt: 0)
        ]
        let tasksData = try JSONEncoder().encode(mockTasks)
        
        // Return data from mock completion handler
        MockURLProtocol.requestHandler = { request in
            if request.description.hasSuffix("current") {
                return (HTTPURLResponse(), relationData)
            } else {
                return (HTTPURLResponse(), tasksData)
            }
        }
        
        // Fetch relation and tasks in view
        relationView.fetchRelationAndTasks()
        
        // Expectation. Used to test async code
        let expectation = XCTestExpectation(description: "fetch")
        // Wait using GCD and then test
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // first time load should be assigned to inActivity
            XCTAssertEqual(relationVM.firstTimeLoad, relationVM.inActivity)
            // View model should be updated with current relation
            XCTAssertEqual(relationVM.currentRelation.id, mockRelation.id)
            XCTAssertEqual(relationVM.currentRelation.endDate, mockRelation.endDate)
            // View model should be updated with tasks for relation
            XCTAssertEqual(relationVM.toDoTasks.count, 1)
            XCTAssertEqual(relationVM.doneTasks.count, 2)
            // Fulfill expecation
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func testMarkAsComplete() throws {
        // Service
        let relationService: RelationService = RelationAPI(urlSession: urlSession)
        // View Model
        let relationVM = RelationViewModel()
        // View
        let relationView = Relation(relationService: relationService, relationViewModel: relationVM)
        
        // Set task tapped
        RelationViewModel.taskTapped = TaskStructure(id: 1, description: "", isDone: false, createdAt: 0, completedAt: 0)
        
        // Set mock json and data
        let mockJSON = RelationModel.ResponseData(message: "test", success: true)
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data form mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // Call Mark task as complete
        relationView.markAsComplete()
        
        // Expectation. Used to test async code
        let expectation = XCTestExpectation(description: "response")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // View model should be updated
            XCTAssertEqual(relationVM.responseData.message, mockJSON.message)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testAddTask() throws {
        // Service
        let relationService: RelationService = RelationAPI(urlSession: urlSession)
        // View Model
        let relationVM = RelationViewModel()
        // View
        let addTaskView = AddTask(relationService: relationService, relationViewModel: relationVM)
        
        // set current relation
        relationVM.currentRelation = RequestStructure(id: 1, mentor: nil, mentee: nil, endDate: 100, notes: "notes")
        
        // Set mock json and data
        let mockJSON = RelationModel.ResponseData(message: "test", success: true)
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data form mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // Call add task action
        addTaskView.addTask()
        
        // Expectation. Used to test async code
        let expectation = XCTestExpectation(description: "response")
        // Wait using GCD and then test in its completion handler
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(relationVM.responseData.message, mockJSON.message)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
