//
//  CalculateViewTests.swift
//  sonar-swift-sampleTests
//
//  Created by Lucas on 14/08/18.
//  Copyright © 2018 Lucas. All rights reserved.
//

import XCTest
@testable import sonar_swift_sample

class CalculateViewTests: XCTestCase {
    
    var view: CalculateViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "CalculateView", bundle: nil)
        let vc: CalculateViewController = storyboard.instantiateViewController(withIdentifier: "CalculateView") as! CalculateViewController
        view = vc
        _ = view.view
    }
    
    func testCalculateTapped() {
        view.calculateTapped(UIButton())
    }
    
    func testShow() {
        view.show(calculationResult: "10000")
    }
}
