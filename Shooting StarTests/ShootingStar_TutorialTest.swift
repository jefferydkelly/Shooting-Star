//
//  ShootingStar_TutorialTest.swift
//  Shooting Star
//
//  Created by igmstudent on 3/3/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import XCTest
@testable import Shooting_Star
class ShootingStar_TutorialTest: XCTestCase {
    
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
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testInit(){
        let t1 = Tutorial()
        XCTAssertNotNil(t1)
    }
    
    func testInit_StepOne_1(){
        let t1 = Tutorial()
        t1.stepOne()
        XCTAssertNotNil(t1)
    }
    
    func testInit_StepOne_2(){
        let t1 = Tutorial()
        t1.stepOne()
        XCTAssertNotNil(t1.infoLabel)
    }
    
    func testInit_StepOne_3(){
        let t1 = Tutorial()
        t1.stepOne()
        XCTAssertNotNil(t1.ship)
    }
    
    func testInit_StepTwo_1(){
        let t1 = Tutorial()
        t1.stepTwo()
        XCTAssertNotNil(t1.infoLabel)
    }
    
    func testInit_StepTwo_2(){
        let t1 = Tutorial()
        t1.stepTwo()
        XCTAssertNotNil(t1.infoLabel2)
    }
    
    func testInit_StepTwo_3(){
        let t1 = Tutorial()
        t1.stepTwo()
        XCTAssertNotNil(t1.ship)
    }
    
    func testInit_StepTwo_4(){
        let t1 = Tutorial()
        t1.stepTwo()
        XCTAssertEqual(t1.infoLabel.text,"Slide your finger along the left side")
    }
    
    func testInit_StepTwo_5(){
        let t1 = Tutorial()
        t1.stepTwo()
        XCTAssertEqual(t1.infoLabel2.text,"to move your ship up and down.")
    }
    
    
    func testInit_StepThree_1(){
        let t1 = Tutorial()
        t1.stepThree()
        XCTAssertNotNil(t1.infoLabel)
    }
    
    func testInit_StepThree_2(){
        let t1 = Tutorial()
        t1.stepThree()
        XCTAssertNotNil(t1.infoLabel2)
    }
    
    func testInit_StepThree_3(){
        let t1 = Tutorial()
        t1.stepThree()
        XCTAssertNotNil(t1.ship)
    }
    
    func testInit_StepThree_4(){
        let t1 = Tutorial()
        t1.stepThree()
        XCTAssertEqual(t1.infoLabel.text,"Tap anywhere ahead of the ship to fire.")
    }
    
    func testInit_StepThree_5(){
        let t1 = Tutorial()
        t1.stepThree()
        XCTAssertNil(t1.infoLabel2.text)
    }
    
    
    func testInit_StepFour_1(){
        let t1 = Tutorial()
        t1.stepFour()
        XCTAssertNotNil(t1.infoLabel)
    }
    
    func testInit_StepFour_2(){
        let t1 = Tutorial()
        t1.stepFour()
        XCTAssertNotNil(t1.infoLabel2)
    }
    
    func testInit_StepFour_3(){
        let t1 = Tutorial()
        t1.stepFour()
        XCTAssertNotNil(t1.ship)
    }
    
    func testInit_StepFour_4(){
        let t1 = Tutorial()
        t1.stepFour()
        XCTAssertEqual(t1.infoLabel.text,"Your normal shot only fires straight ahead so")
    }
    
    func testInit_StepFour_5(){
        let t1 = Tutorial()
        t1.stepFour()
        XCTAssertEqual(t1.infoLabel2.text,"you'll have to be in front of whatever you fire at")
    }

    func test_StepFive_1(){
        let t1 = Tutorial()
        t1.stepFive()
        XCTAssertEqual(t1.infoLabel.text,"Like this asteroid.")
    }
    
    func test_StepFive_2(){
        let t1 = Tutorial()
        t1.stepFive()
        XCTAssertNotNil(t1.ship)
    }
    
    func test_StepFive_3(){
        let t1 = Tutorial()
        t1.stepFive()
        XCTAssertNotNil(t1.curStep)
    }
    
    func test_Utils_1(){
        let CGPoint1 = CGPoint(x:20,y:20)
        let CGPoint2 = CGPoint(x:30,y:10)
        let CGPoint3 = CGPoint1 + CGPoint2
        XCTAssertNotNil(CGPoint3.x)
        XCTAssertEqual(CGPoint3.x, 50)
        XCTAssertEqual(CGPoint3.y, 30)
        
    }
    
    func test_Utils_2(){
        var CGPoint1 = CGPoint(x:20,y:20)
        let CGPoint2 = CGPoint(x:30,y:10)
        CGPoint1+=CGPoint2
        XCTAssertNotNil(CGPoint1.x)
        XCTAssertEqual(CGPoint1.x, 50)
        XCTAssertEqual(CGPoint1.y, 30)
    }
    
    func test_Utils_3(){
        let CGPoint1 = CGPoint(x:20,y:20)
        let CGPoint2 = CGPoint(x:30,y:10)
        let CGPoint3 = CGPoint1 - CGPoint2
        XCTAssertNotNil(CGPoint3)
        XCTAssertEqual(CGPoint3.x, -10)
        XCTAssertEqual(CGPoint3.y, 10)
    }
    
    func test_Utils_4(){
        var CGPoint1 = CGPoint(x:20,y:20)
        let CGPoint2 = CGPoint(x:30,y:10)
        CGPoint1-=CGPoint2
        XCTAssertNotNil(CGPoint1)
        XCTAssertEqual(CGPoint1.x, -10)
        XCTAssertEqual(CGPoint1.y, 10)
    }
}
