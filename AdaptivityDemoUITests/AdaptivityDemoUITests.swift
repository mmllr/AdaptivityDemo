//
//  AdaptivityDemoUITests.swift
//  AdaptivityDemoUITests
//
//  Created by Markus Müller on 27.12.15.
//  Copyright © 2015 Markus Müller. All rights reserved.
//

import XCTest

class AdaptivityDemoUITests: XCTestCase {
	var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        
		app = XCUIApplication()
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
		
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func ensureTheMasterTableIsVisible() {
		if app.navigationBars["Detail"].buttons["Master"].exists {
			app.navigationBars["Detail"].buttons["Master"].tap()
		}
	}
	
	func pressAddButtonInMasterBar() {
		app.navigationBars["Master"].buttons["Add"].tap()
	}

	func startEditingMasterContent() {
		app.navigationBars["Master"].buttons["Edit"].tap()
	}
	
	func endEditingMasterContent() {
		app.navigationBars["Master"].buttons["Done"].tap()
	}

	func deleteItemInTable(table: XCUIElementQuery, atIndex: UInt) {
		let cell = table.cells.elementBoundByIndex(atIndex)
		cell.buttons.elementBoundByIndex(0).tap()
		cell.buttons.elementBoundByIndex(1).tap()
	}

	func navigateToItem(item: String, inTable: XCUIElementQuery) {
		inTable.staticTexts[item].tap()
	}

	func ensureDetailViewIsVisible() {
		let popOverDismissRegion = XCUIApplication().otherElements["PopoverDismissRegion"]
		if popOverDismissRegion.exists {
			popOverDismissRegion.tap()
		}
	}
	
    func testAddingAndRemovingAnItem() {
		ensureTheMasterTableIsVisible()

		let table = app.tables

		XCTAssertEqual(table.cells.count, 0)

		pressAddButtonInMasterBar()

		XCTAssertEqual(table.cells.count, 1)

		navigateToItem("Item 1", inTable: table)
		ensureDetailViewIsVisible()

		XCTAssertTrue(app.staticTexts["DetailContentLabel"].exists)
		XCTAssertEqual(app.staticTexts["DetailContentLabel"].label, "Item 1")

		ensureTheMasterTableIsVisible()
		startEditingMasterContent()
		deleteItemInTable(table, atIndex: 0)
		endEditingMasterContent()

		XCTAssertEqual(table.cells.count, 0)
    }
}
