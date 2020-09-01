//
//  mentorship_iosTests.swift
//  Created on 30/05/20.
//  Created for AnitaB.org Mentorship-iOS
//

import XCTest
import Combine
@testable import mentorship_ios

class MentorshipTests: XCTestCase {
    var urlSession: URLSession!
    
    override func setUpWithError() throws {
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        urlSession = nil
        super.tearDown()
    }
    
    //this test requires a stable internet connection
    func testBackendServerURL() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Download mentorship backend base url")
        
        // Create a URL for a web page to be downloaded.
        let url = URL(string: baseURL)!
        
        // Create a background task to download the web page.
        let cancellable: AnyCancellable?
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .assertNoFailure()
            .sink {
                // Make sure we downloaded some data.
                XCTAssertNotNil($0, "No data was downloaded.")
                
                // Fulfill the expectation to indicate that the background task has finished successfully.
                expectation.fulfill()
        }
        
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }

}
