//
//  final_projectUITests.swift
//  final_projectUITests
//
//  Created by Jackson on 16/08/22.
//

import XCTest

class final_projectUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["The Shawshank Redemption"]/*[[".cells.staticTexts[\"The Shawshank Redemption\"]",".staticTexts[\"The Shawshank Redemption\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
