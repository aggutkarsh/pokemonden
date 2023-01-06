//
//  HeaderViewTests.swift
//  PokémonDenUITests
//
//  Created by Utkarsh Agrawal on 30/12/22.
//

import XCTest
@testable import PokemonDen

class HeaderViewTests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHeader() throws {
        let header = app.staticTexts.element.firstMatch
        XCTAssert(header.exists)
        XCTAssertEqual(header.label, "PokémonDen")
    }
    
    func testSubHeader() throws {
        let subHeader = app.staticTexts.element(boundBy: 1)
        XCTAssert(subHeader.exists)
        XCTAssertEqual(subHeader.label, "Search for any Pokémon that exists on the planet")
    }
}
