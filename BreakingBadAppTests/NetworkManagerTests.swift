//
//  NetworkManagerTests.swift
//  BreakingBadAppTests
//
//  Created by Melvin Asare on 19/03/2021.
//

@testable import BreakingBadApp
import XCTest

class NetworkManagerTests: XCTestCase {

    var mockNetworkManager: MockNetworkManagerTest!


    func testMockNetworkCall() {
        mockNetworkManager.fetchCharacterData { json, error in
            print(json)
        }
    }



    override func setUp() {
        super.setUp()
    }

    

    override func tearDown() {
        super.tearDown()
    }

}
