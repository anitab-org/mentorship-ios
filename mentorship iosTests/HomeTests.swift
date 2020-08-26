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
    }

    override func tearDownWithError() throws {
        urlSession = nil
        super.tearDown()
    }
    
    // MARK: - Serivce Tests
    
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
}
