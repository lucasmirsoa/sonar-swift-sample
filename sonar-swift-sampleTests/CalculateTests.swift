//
//  sonar_swift_sampleTests.swift
//  sonar-swift-sampleTests
//
//  Created by Lucas on 13/08/18.
//  Copyright © 2018 Lucas. All rights reserved.
//

import XCTest
@testable import sonar_swift_sample

class CalculateTests: XCTestCase {

    private var view: CalculateViewController = CalculateViewController()

    private lazy var presenter: CalculatePresenter = {
        return CalculatePresenter(view: view)
    }()

    override func setUp() {
        super.setUp()
    }

    func testTryGenerateOperationSuccess() {
        XCTAssertNotNil(presenter.tryGenerateOperation(firstValue: "1234", secondValue: "12345"), "String with valid int number should be ok")
    }

    func testTryGenerateOperationFailure() {
        XCTAssertNil(presenter.tryGenerateOperation(firstValue: "123quatro", secondValue: "12345"), "String must contain only int values")
    }

    func testCalculate() {
        // "Basic bad operation"
        presenter.calculate(operation: nil, testing: true)

        // "Basic good operation"
        presenter.calculate(operation: Operation(value1: 100, value2: 200), testing: true)
    }
}
