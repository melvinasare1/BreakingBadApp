//
//  NetworkManagerTests.swift
//  BreakingBadAppTests
//
//  Created by Melvin Asare on 19/03/2021.
//

@testable import BreakingBadApp
import XCTest

class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
    }

    

    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }

}
