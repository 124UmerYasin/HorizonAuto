//
//  Horizon_AutoUITests.swift
//  Horizon AutoUITests
//
//  Created by Umer Yasin on 14/04/2023.
//

import XCTest

final class Horizon_AutoUITests: XCTestCase {

    func testApplySearchFromHome(){
        let app = XCUIApplication()
        app.launch()
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .button).element.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["C1"]/*[[".cells.staticTexts[\"C1\"]",".staticTexts[\"C1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Modified or Track Only"]/*[[".cells.staticTexts[\"Modified or Track Only\"]",".staticTexts[\"Modified or Track Only\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
                tablesQuery.staticTexts["Corvette Convertible"].tap()
        app.buttons["Apply Filters"].tap()
        let trackInfoLabel = app.staticTexts["Corvette Convertible"]

        XCTAssertEqual(trackInfoLabel.exists, true)

    }
}
