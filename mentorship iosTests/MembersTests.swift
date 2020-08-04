//
//  MembersTests.swift
//  Created on 26/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import XCTest
@testable import mentorship_ios

class MembersTests: XCTestCase {
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
    
    // MARK: - Service Tests
    
    func testFetchMembersService() throws {
        let membersService: MembersService = MembersAPI(urlSession: urlSession)
        
        // Set mock json and data
        let mockJSON = [MembersModel.MembersResponseData]()
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data form mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // MARK: List should be full.
        
        let expectation = XCTestExpectation(description: "fetch1")
        membersService.fetchMembers(pageToLoad: 1, perPage: 20) { resp, listFull in
            XCTAssertEqual(resp.count, 0)
            // list should be full, 0 < 20
            XCTAssertEqual(listFull, true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
                
        // MARK: List should not be full.
        
        let expectation2 = XCTestExpectation(description: "fetch2")
        membersService.fetchMembers(pageToLoad: 1, perPage: 0) { resp, listFull in
            // 0 is NOT lesser than 0
            XCTAssertEqual(listFull, false)
            expectation2.fulfill()
        }
        wait(for: [expectation2], timeout: 1)
    }
    
    func testSendRequestService() throws {
        let membersService: MembersService = MembersAPI(urlSession: urlSession)

        // Set mock json and data
        let mockJSON = MembersModel.SendRequestResponseData(message: "test", success: true)
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data form mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // Expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        membersService.sendRequest(menteeID: 0, mentorID: 1, endDate: 0, notes: "") { resp in
            XCTAssertEqual(resp.message, mockJSON.message)
            XCTAssertEqual(resp.success, true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: - MembersViewModel tests
    
    func testAvailabilityString() {
        let membersVM = MembersViewModel()
        
        // Can be both - mentor and mentee
        XCTAssertEqual(membersVM.availabilityString(canBeMentee: true, canBeMentor: true), LocalizableStringConstants.canBeBoth)
        
        // Can be mentor only
        XCTAssertEqual(membersVM.availabilityString(canBeMentee: false, canBeMentor: true), LocalizableStringConstants.canBeMentor)
        
        // Can be mentee only
        XCTAssertEqual(membersVM.availabilityString(canBeMentee: true, canBeMentor: false), LocalizableStringConstants.canBeMentee)
        
        // Not available
        XCTAssertEqual(membersVM.availabilityString(canBeMentee: false, canBeMentor: false), LocalizableStringConstants.notAvailable)
    }
    
    func testSkillsString() {
        let membersVM = MembersViewModel()

        // Test skill
        XCTAssertEqual(membersVM.skillsString(skills: "test"), "Skills: test")
        
        // Empty skill
        XCTAssertEqual(membersVM.skillsString(skills: ""), "Skills: ")
    }
    
    // MARK: - View Tests (Integration Tests)

    func testFetchMembersAction() throws {
        // Service
        let membersService: MembersService = MembersAPI(urlSession: urlSession)
        // View Model
        let membersVM = MembersViewModel()
        // View
        let membersView = Members(membersService: membersService, membersViewModel: membersVM)
        
        // Set mock json and data
        let mockJSON = [MembersModel.MembersResponseData]()
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data form mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // make current page = 0
        membersVM.currentPage = 0
        
        // Call fetch members action
        membersView.fetchMembers()
        
        // Expectation. Test async code
        let expectation = XCTestExpectation(description: "members")
        // Wait using GCD and then test
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // View model should be updated
            XCTAssertEqual(membersVM.inActivity, false)
            XCTAssertEqual(membersVM.currentPage, 1)
            XCTAssertEqual(membersVM.membersResponseData.count, 0)
            // fulfill expectation
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testSendRequestAction() throws {
        // Service
        let membersService: MembersService = MembersAPI(urlSession: urlSession)
        // View Model
        let membersVM = MembersViewModel()
        // View
        let sendRequestView = SendRequest(membersService: membersService, membersViewModel: membersVM, memberID: 0, memberName: "")
        
        // Set mock json and data
        let mockJSON = MembersModel.SendRequestResponseData(message: "test", success: true)
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data form mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // call send request action
        sendRequestView.sendRequest()
        
        // Expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        // Wait using GCD and then test
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // view model should be updated with response. Test
            XCTAssertEqual(membersVM.sendRequestResponseData.message, mockJSON.message)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
