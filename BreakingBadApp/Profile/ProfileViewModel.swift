//
//  ProfileViewModel.swift
//  BreakingBadApp
//
//  Created by Melvin Asare on 14/03/2021.
//

import Foundation

class ProfileViewModel {

    public var characterData: Character
    public var showStatusLabel = false

    init(characterData: Character) {
        self.characterData = characterData
    }
}
