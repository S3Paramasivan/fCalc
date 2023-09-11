//
//  Tester.swift
//  Tester
//
//  Created by SivA on 9/11/23.
//

import XCTest
import fCalc

final class Tester: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        [
            "1/2 * 3&3/4": "1&7/8",
            "2&3/8 + 9/8": "3&1/2",
            "1&3/4 - 2": "-1/4",
            "1&3/4 + -2&3/4": "-1",
            "-1&3/4 + -2&3/4": "-4&1/2",
        ].forEach { testCase in
            XCTAssertEqual(testCase.key.evaluate(), testCase.value)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
