//
//  StackOperationsTests.swift
//  StackOperationsTests
//
//  Created by sanooj on 11/4/17.
//

import XCTest
@testable import StackOperations

class StackOperationsTests: XCTestCase {
    
    var stack:Stack<Date> =
        Stack<Date>()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class
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

//MARK: - Validation API Tests
extension StackOperationsTests
{
    func testInvalidDateFormat()
    {
        let dateString =
        "222/222/222"
        
        let dateFormat =
        "dd/MM/yyyy"
        
        let validatorStatus =
        Utilities.Validators.DateValidator.validateDate(
            dateString,
            againstFormat: dateFormat
        )
        
        XCTAssert(validatorStatus == false, "Invalid date Format Detected")
    }
    
    func testAlphanumericInputAsDate()
    {
        let dateString =
        "2abcd2222"
        
        let dateFormat =
        "dd/MM/yyyy"
        
        let validatorStatus =
            Utilities.Validators.DateValidator.validateDate(
                dateString,
                againstFormat: dateFormat
        )
        
        XCTAssert(validatorStatus == false, "AlphanumericInput Detected")
    }
    
    func testEmptyStringAsDate()
    {
        let dateString =
        ""
        
        let dateFormat =
        "dd/MM/yyyy"
        
        let validatorStatus =
            Utilities.Validators.DateValidator.validateDate(
                dateString,
                againstFormat: dateFormat
        )
        
        XCTAssert(validatorStatus == false, "Empty String Detected")
    }
    
    func testValidStringAsDate()
    {
        let dateString =
        "1/1/1"
        
        let dateFormat =
        "dd/MM/yyyy"
        
        let validatorStatus =
            Utilities.Validators.DateValidator.validateDate(
                dateString,
                againstFormat: dateFormat
        )
        
        XCTAssert(validatorStatus == true, "Valid Date String Detected")
    }
}

//MARK: - Formatter API Tests
typealias StringToDateAPITests = StackOperationsTests
extension StringToDateAPITests
{
    //stringTodate
    func testEmptyStringAsDateString()
    {
        let dateString =
        ""
        
        let dateFormat =
        "dd/MM/yyyy"
        
        let date:Date? =
        Utilities.Formatters.getDateFrom(
            dateString: dateString,
            dateFormat: dateFormat
        )
        
        XCTAssertNil(date, "Empty String Detected")
    }
}

typealias DateToStringAPITests = StackOperationsTests
extension DateToStringAPITests
{
    //dateToString
    func testStringFromDate()
    {
        let date =
        Date()
    
        let dateStringForDate:String =
            Utilities.Formatters.getStringFrom(date: date)
        
        XCTAssert(dateStringForDate.isEmpty == false, "Valid Date String")
    }
}

//MARK: - Localization API Tests
typealias LocalizationAPITests = StackOperationsTests
extension LocalizationAPITests
{
    func testLocalizationKeyAvailability()
    {
        let key =
        "EMPTY_STRING_ALERT_MESSAGE"
        
        let localizedString =
        Utilities.Localization.localize(key: key)
        
        XCTAssert(localizedString != key, "Key available")
    }
    
    func testLocalizationKeyUnAvailability()
    {
        let key =
        "RANDOM_KEY"
        
        let localizedString =
            Utilities.Localization.localize(key: key)
        
        XCTAssert(localizedString == key , "RANDOM_KEY")
    }
}

typealias StackDataStructureAPITests = StackOperationsTests
extension StackDataStructureAPITests
{
    func testPush()
    {
        let date =
        Date()
        
        self.stack.push(date)
        
        XCTAssert(self.stack.count > 0, "Pushed")
    }
    
    func testPoppingAnEmptyStack()
    {
        //precondition - stack needs to be empty
        self.stack.clear()
        
        let poppedItem:Date? =
            self.stack.pop()
        
        XCTAssertNil(poppedItem, "Empty Stack")
    }
    
    func testPoppingAFilledStack()
    {
        //precondition - stack needs to be full
        //precondition set up
        let date =
            Date()
        
        self.stack.push(date)
        
        let poppedItem:Date? =
        self.stack.pop()
        
        XCTAssert(poppedItem != nil, "Popped")
    }
    
    func testObjectAccesAtAnIndexLargerThanTheLengthOfTheStack()
    {
        let item:Date? =
        self.stack.object(atIndex: self.stack.count + 1)
        
        XCTAssertNil(item, "Index out of range")
    }
    
    func testCountIncrement()
    {
        let countBeforePush:Int =
            self.stack.count
        
        let date =
            Date()

        //push
        self.stack.push(date)
        
        XCTAssert(countBeforePush < self.stack.count, "Count Incremented")
    }
    
    func testCountDecement()
    {
        //precondition - stack needs to have atleast one element
        let date =
            Date()
        
        //push
        self.stack.push(date)
        
        let countBeforePop:Int =
            self.stack.count
        
        self.stack.pop()
        
        XCTAssert(countBeforePop > self.stack.count, "Count Decremented")
    }
    
    //also works as a test for clearAll
    func testIsEmptyFlag()
    {
        //precondition - stack needs to have atleast one element
        let date =
            Date()
        
        //push
        self.stack.push(date)
    
        //clear all
        self.stack.clear()
        
         XCTAssertTrue(self.stack.isEmpty, "Stack is Empty")
    }
    
    func testClearAll()
    {
        //precondition - stack needs to have atleast one element
        let date =
            Date()
        
        //push
        self.stack.push(date)
        
        //clear all
        self.stack.clear()
        
        XCTAssertTrue(self.stack.count == 0, "Stack is Empty")
    }
    
    func testPeekAnEmptyStack()
    {
        //precondition - stack needs to be empty
        self.stack.clear()
        
        let peek:Date? =
            self.stack.peek()
        
        XCTAssertNil(peek, "Stack is Empty. Nothing to peek")
    }
    
    func testPeekAFilledStack()
    {
        //precondition - stack needs to have atleast one element
        let date =
            Date()
        
        //push
        self.stack.push(date)
        
        let peek:Date? =
            self.stack.peek()
        
        XCTAssertNotNil(peek ,"Stack can be peeked")
    }
    
    func testSort()
    {
        let referenceDate =
        Date()
        
        let unSortedArray =
            [referenceDate.addingTimeInterval(2.0) ,
             referenceDate.addingTimeInterval(1.0),
             referenceDate.addingTimeInterval(4.0),
             referenceDate.addingTimeInterval(3.0),
        ]
        
        let sortedArray =
        unSortedArray.sorted()
        
        //clear
        self.stack.clear()
        
        //push sorted Array to Stack
        for item in unSortedArray
        {
            self.stack.push(item)
        }
        
        //sort
        self.stack.sort()
        
        //compare
        for index in 0..<unSortedArray.count
        {
            XCTAssertTrue(sortedArray[index] == self.stack.object(atIndex: index))
        }
    }
}
