//
//  SpecialCharacterTest.swift
//  BreakingBadAppTests
//
//  Created by Melvin Asare on 20/03/2021.
//
@testable import BreakingBadApp
import XCTest

class SpecialCharacterTest: XCTestCase {

    var homePage = HomePageViewController(viewModel: HomePageViewModel())

    override func setUp() {
        super.setUp()
    }

    func testSpecialCharacterInput() {
       XCTAssertFalse(homePage.hasSpecChars(text: "Skyler White"))
    }

    override func tearDown() {
        super.tearDown()
    }
}
