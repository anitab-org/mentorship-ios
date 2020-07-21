//
//  mentorship_iosTests.swift
//  Created on 30/05/20.
//  Created for AnitaB.org Mentorship-iOS
//

import XCTest
import Combine
@testable import mentorship_ios

class MentorshipTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
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
