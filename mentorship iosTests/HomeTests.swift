//
//  HomeTests.swift
//  Created on 26/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import XCTest
@testable import mentorship_ios

class HomeTests: XCTestCase {
    // custom urlsession for mock network calls
    var urlSession: URLSession!

    override func setUpWithError() throws {
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        
        // set temp keychain token
        // api calls require a token, otherwise tests fail
        try KeychainManager.setToken(username: "", tokenString: "")
    }

    override func tearDownWithError() throws {
        urlSession = nil
        try KeychainManager.deleteToken()
        super.tearDown()
    }
    
    // MARK: - Serivce Tests
    func testRequestAction() throws {
        // Set mock json for server response
        let mockJSON = RequestActionResponse(message: "response message")
        // Create mock data from mock json
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Use mock protocol, and return mock data and url response from handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        // Expectation. Used for testing async code.
        let expectation = XCTestExpectation(description: "response")
        
        // Declare service and test response
        let requestActionService: RequestActionService = RequestActionAPI(urlSession: urlSession)
        requestActionService.actOnPendingRequest(action: .accept, reqID: 0) { response, _ in
            // Test if correct response is returned.
            XCTAssertEqual(response.message, mockJSON.message)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testHomeService() throws {
        // Home Service
        let homeService: HomeService = HomeAPI(urlSession: urlSession)

        // Set mock json and data
        let mockJSON = homeResponseJSONString
        let mockData = mockJSON.data(using: .utf8)!
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        
        // Make fetch dashboard request and test response data.
        homeService.fetchDashboard { resp in
            XCTAssertEqual(resp.tasksToDo?.count, 1)
            XCTAssertEqual(resp.tasksDone?.count, 2)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
     
    func testUserFirstName() {
 
        //Test computed first name
        let testHome = Home()
        
        // Set User name for general first name isolation
        testHome.homeViewModel.userName = "Jane Alice Smith"
        XCTAssertEqual(testHome.userFirstName, "Jane")
        
        // Set User name with leading spaces
        testHome.homeViewModel.userName = "  Jane Alice Smith"
        XCTAssertEqual(testHome.userFirstName, "Jane")
        
        // Set User name for proper name capitalization
        testHome.homeViewModel.userName = "jaNe Alice Smith"
        XCTAssertEqual(testHome.userFirstName, "Jane")
        
        // Set User name as optional nil
        testHome.homeViewModel.userName = nil
        XCTAssertEqual(testHome.userFirstName, "")
 
    }
    
}
