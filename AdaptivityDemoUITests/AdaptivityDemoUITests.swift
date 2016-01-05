//
//  AdaptivityDemoUITests.swift
//  AdaptivityDemoUITests
//
//  Created by Markus Müller on 27.12.15.
//  Copyright © 2015 Markus Müller. All rights reserved.
//

import XCTest

class AdaptivityDemoUITests: XCTestCase {
        
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
    
    func testAddingAndRemovingAnItem() {
		let app = XCUIApplication()
		let masterNavigationBar = app.navigationBars["Master"]
		if app.navigationBars["Detail"].buttons["Master"].exists {
			app.navigationBars["Detail"].buttons["Master"].tap()
		}
		let table = app.tables

		XCTAssertEqual(table.cells.count, 0)

		masterNavigationBar.buttons["Add"].tap()

		XCTAssertEqual(table.cells.count, 1)

		table.staticTexts["Title"].tap()
		if !masterNavigationBar.exists {
			app.navigationBars.matchingIdentifier("Detail").buttons["Master"].tap()
		}
		masterNavigationBar.buttons["Edit"].tap()

		app.buttons["Delete Item 1"].tap()
		app.tables.buttons["Delete"].tap()
		
		
		masterNavigationBar.buttons["Done"].tap()

		XCTAssertEqual(table.cells.count, 0)
    }
}
