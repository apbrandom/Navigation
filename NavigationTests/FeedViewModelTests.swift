//
//  NavigationTests.swift
//  NavigationTests
//
//  Created by Vadim Vinogradov on 03.08.2023.
//

import XCTest
@testable import Navigation

final class FeedViewModelTests: XCTestCase {
    
    var sut: FeedViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = FeedViewModel()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testGenerateAndCrackPasswordTriggersCallbacks() throws {
        // given
        let passwordExpectation = expectation(description: "Password should be updated.")
        let activityIndicatorExpectation = expectation(description: "Activity Indicator state should be updated twice.")
        let timerExpectation = expectation(description: "Timer should be updated.")
        let passwordStatusExpectation = expectation(description: "Password status should be updated.")
        activityIndicatorExpectation.expectedFulfillmentCount = 2
        
        sut.passwordUpdated = { password in
            XCTAssertNotNil(password)
            passwordExpectation.fulfill()
        }
        
        sut.activityIndicatorState = { isAnimating in
            activityIndicatorExpectation.fulfill()
        }
        
        sut.passwordStatus = { isCracked in
            XCTAssertTrue(isCracked)
            passwordStatusExpectation.fulfill()
        }
        
        var isTimerExpectationFulfilled = false

        sut.timerUpdated = { timeString in
            XCTAssertNotNil(timeString)
            if !isTimerExpectationFulfilled {
                timerExpectation.fulfill()
                isTimerExpectationFulfilled = true
            }
        }
        
        // when
        sut.generateAndCrackPassword()
        
        // then
        wait(for: [passwordExpectation, activityIndicatorExpectation, timerExpectation, passwordStatusExpectation], timeout: 180)
    }
    
    func testGenerateAndCrackPasswordGeneratesValidPassword() throws {
        // given
        let passwordExpectation = expectation(description: "Password should be updated.")
        
        sut.passwordUpdated = { password in
            XCTAssertEqual(password.count, 4)
            passwordExpectation.fulfill()
        }
        
        // when
        sut.generateAndCrackPassword()
        
        // then
        wait(for: [passwordExpectation], timeout: 1)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
            sut.generateAndCrackPassword()
        }
    }
    
}
