//
//  TheBestiOSProjectTests.swift
//  TheBestiOSProjectTests
//
//  Created by sanooj on 11/2/17.
//  Copyright © 2017 DCore. All rights reserved.
//

import XCTest
@testable import TheBestiOSProject

class TheBestiOSProjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testWebCallWithGetHttpMethod()
    {
        let url  = "https://jsonplaceholder.typicode.com"
        let path  = "users"
        
        let expectation =
            self.expectation(description: "Networkrequest")
        
        HTTPRequest().request(
            withBaseURL: url, andPath: path
            ).ofType(
                method: HTTPMethod.delete
            ).withSessionType(
                sessionType: URLSessionType.shared
                )
            { (data:Data?, response:URLResponse? , error:Error?) in
                
                //test Nil response
                XCTAssert(response != nil, "non \"Nil\" response Recieved")
                
                //unwrapped
                //so this wont execute if the first test fails
                //this should be a separate test
                if let response = response as? HTTPURLResponse
                {
                    //test 200 response
                    XCTAssert(response.statusCode == 200, "status != 200")
                }
                
                
                expectation.fulfill()
                
            }.make()
        
        self.wait(for: [expectation], timeout: TimeInterval.init(60.0))
    }
    
    func testSampleWebCallWithDeleteHttpMethod()
    {
        let url  = "https://jsonplaceholder.typicode.com"
        let path  = "users"
        
        let expectation =
            self.expectation(description: "Networkrequest")
        
        HTTPRequest().request(
            withBaseURL: url, andPath: path
            ).ofType(
                method: HTTPMethod.delete
            ).withSessionType(
                sessionType: URLSessionType.shared
                )
            { (data:Data?, response:URLResponse? , error:Error?) in
                
                //test Nil response
                XCTAssert(response == nil, "\"Nil\" response Recieved")
                
                //unwrapped
                //so this wont execute if the first test fails
                //this should be a separate test
                if let response = response as? HTTPURLResponse
                {
                    //test 200 response
                    XCTAssert(response.statusCode == 200, "status != 200")
                }
                
                
                expectation.fulfill()
                
            }.make()
        
        self.wait(for: [expectation], timeout: TimeInterval.init(60.0))
    }
    
    func testSampleWebCallWithBlankURL()
    {
        let url  = ""
        let path  = ""
        
        let expectation =
            self.expectation(description: "Networkrequest")
        
        HTTPRequest().request(
            withBaseURL: url, andPath: path
            ).ofType(
                method: HTTPMethod.delete
            ).withSessionType(
                sessionType: URLSessionType.shared
                )
            { (data:Data?, response:URLResponse? , error:Error?) in
                
                //test Nil response
                XCTAssert(response == nil, "\"Nil\" response Recieved")
                
                //unwrapped
                //so this wont execute if the first test fails
                //this should be a separate test
                if let response = response as? HTTPURLResponse
                {
                    //test 200 response
                    XCTAssert(response.statusCode == 200, "status != 200")
                }
                
                
                expectation.fulfill()
                
            }.make()
        
        self.wait(for: [expectation], timeout: TimeInterval.init(60.0))
    }
    
}
