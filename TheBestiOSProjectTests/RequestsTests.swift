//
//  RequestsTests.swift
//  TheBestiOSProjectTests
//
//  Created by Sanooj on 17/06/2018.
//  Copyright © 2018 DCore. All rights reserved.
//

import XCTest
@testable import TheBestiOSProject

class RequestsTests: XCTestCase {
    
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
    
}

//MARK: Testing URlComponents
extension RequestsTests
{
    func testURLComponents()
    {
        let urlString = "http://www.example.com"
        
        
        guard let urlComponents: URLComponents =
            URLComponents.init(string: urlString) else
        {
            return
        }
        
        print(urlComponents.fragment as Any)
    }
}
