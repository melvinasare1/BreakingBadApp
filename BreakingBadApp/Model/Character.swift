//
//  Character.swift
//  BreakingBadProject
//
//  Created by Melvin Asare on 12/03/2021.
//

import Foundation

struct Character: Decodable {
    let char_id: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let img: String
    let status: String
    let nickname: String
    let appearance: [Int]
    let portrayed: String
    let category: String

    let uuid = UUID()
}

extension Character: Hashable {
    static func ==(lhs: Character, rhs: Character) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
