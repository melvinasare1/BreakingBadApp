//
//  MockNetworkManagerTest.swift
//  BreakingBadAppTests
//
//  Created by Melvin Asare on 28/03/2021.
//

@testable import BreakingBadApp

import XCTest

class MockNetworkManagerTest: XCTestCase {

    var fetchCharacterDataCalled = false
    var shouldReturnError = false

    enum MockNetworkManagerError {
        case fetchCharacterData
    }

    func reset() {
        fetchCharacterDataCalled = false
    }

    let mockupData: [String: Any] = [
        "char_id":1,
        "name":"Walter White",
        "birthday":"09-07-1958",
        "occupation":[
            "High School Chemistry Teacher",
            "Meth King Pin"
        ],
        "img":"https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
        "status":"Presumed dead",
        "nickname":"Heisenberg",
        "appearance":[1, 2, 3, 4, 5],
        "portrayed":"Bryan Cranston",
        "category":"Breaking Bad",
        "better_call_saul_appearance":[ ]
    ]
}

extension MockNetworkManagerTest: NetworkManagerProtocol {
    func fetchCharacterData(_ completion: @escaping ([String: Any]?, Error?) -> Void) {
        fetchCharacterDataCalled = true

        if shouldReturnError {
            print("error")
        } else {
            completion(mockupData, nil)
        }
    }


}
