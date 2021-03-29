//
//  EndpointTest.swift
//  BreakingBadAppTests
//
//  Created by Melvin Asare on 28/03/2021.
//

@testable import BreakingBadApp
import XCTest

class EndpointTest: XCTestCase {

    var networkManager: NetworkManager?

    func testEndpointHasntChanged() {
        XCTAssertEqual("https://breakingbadapi.com/api/characters", networkManager?.endpoint )
    }
}
