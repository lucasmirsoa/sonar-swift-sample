//
//  sonar_swift_sampleTests.swift
//  sonar-swift-sampleTests
//
//  Created by Lucas on 13/08/18.
//  Copyright © 2018 Lucas. All rights reserved.
//

import XCTest
@testable import sonar_swift_sample

class CalculatePresenterTests: XCTestCase {

    private lazy var presenter: CalculatePresenter = {
        return CalculatePresenter(view: CalculateViewController())
    }()

    override func setUp() {
        super.setUp()
    }

    func testCalculateViewTapped() {
        // "Basic good operations"
        presenter.calculateViewTapped(firstValue: "123", secondValue: "1233", testing: true)
        presenter.calculateViewTapped(firstValue: "0", secondValue: "1233", testing: true)

        // "Basic bad operation"
        presenter.calculateViewTapped(firstValue: nil, secondValue: "1233", testing: true)
        presenter.calculateViewTapped(firstValue: "", secondValue: "1233", testing: true)
    }
    
    func testTryGenerateOperationSuccess() {
        XCTAssertNotNil(presenter.tryGenerateOperation(firstValue: "1234", secondValue: "12345"), "String with valid int number should be ok")
        XCTAssertNotNil(presenter.tryGenerateOperation(firstValue: "0", secondValue: "12345"), "String with valid int number should be ok")
    }

    func testTryGenerateOperationFailure() {
        XCTAssertNil(presenter.tryGenerateOperation(firstValue: nil, secondValue: "12345"), "String must contain only int values")
        XCTAssertNil(presenter.tryGenerateOperation(firstValue: "", secondValue: "12345"), "String must contain only int values")
        XCTAssertNil(presenter.tryGenerateOperation(firstValue: "123quatro", secondValue: "12345"), "String must contain only int values")
    }

    func testCalculate() {
        // "Basic bad operation"
        presenter.calculate(operation: nil, testing: true)

        // "Basic good operation"
        presenter.calculate(operation: Operation(value1: 100, value2: 200), testing: true)
    }
}
