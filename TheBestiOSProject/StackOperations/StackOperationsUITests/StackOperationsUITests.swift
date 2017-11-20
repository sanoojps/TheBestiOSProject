//
//  StackOperationsUITests.swift
//  StackOperationsUITests
//
//  Created by sanooj on 11/4/17.
//

import XCTest

class StackOperationsUITests: XCTestCase {
    
    
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
    func testPush()
    {
        let app = XCUIApplication()
        
        let ddMmYyyyTextField = app.textFields["DD/MM/YYYY"]
        ddMmYyyyTextField.tap()
        ddMmYyyyTextField.typeText("2/3/4")
        
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let pushButton = app.buttons["PUSH"]
        pushButton.tap()
        
        XCTAssertTrue(app.tables.cells.element(boundBy: 0).exists,"Cell created")
    }
    
    func testPop()
    {
        let app = XCUIApplication()
        
        let ddMmYyyyTextField = app.textFields["DD/MM/YYYY"]
        ddMmYyyyTextField.tap()
        ddMmYyyyTextField.typeText("2/3/4")
        
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let pushButton = app.buttons["PUSH"]
        pushButton.tap()
        
        let popButton = app.buttons["POP"]
        popButton.tap()
        
        XCTAssertFalse(app.tables.cells.element(boundBy: 0).exists,"Cell Distroyed")
    }
    
    func testClear()
    {
        let app = XCUIApplication()
        
        let ddMmYyyyTextField = app.textFields["DD/MM/YYYY"]
        ddMmYyyyTextField.tap()
        ddMmYyyyTextField.typeText("2/3/4")
        
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let pushButton = app.buttons["PUSH"]
        pushButton.tap()
        
        let clearButton = app.buttons["CLEAR"]
        clearButton.tap()
        
        XCTAssertTrue(app.tables.cells.staticTexts.count == 0,"Cell Distroyed")
    }
    
    func testSort()
    {
        let app = XCUIApplication()
        let ddMmYyyyTextField = app.textFields["DD/MM/YYYY"]
        ddMmYyyyTextField.tap()
        ddMmYyyyTextField.typeText("2/3/4")
        
        let pushButton = app.buttons["PUSH"]
        pushButton.tap()
        
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        "2/3/4".forEach { (char) in
            deleteKey.tap()
        }
        
        ddMmYyyyTextField.typeText("1/2/3")
        
        pushButton.tap()
        
        app.buttons["SORT"].tap()
        
        XCTAssertTrue(app.tables.cells.element(boundBy: 0).staticTexts["01/02/0003"].exists,"Cell 01/02/0003 Exists")
        
        XCTAssertTrue(app.tables.cells.element(boundBy: 1).staticTexts["02/03/0004"].exists ,"Cell 02/03/0004 Exists")
        
        
    }
    
}
