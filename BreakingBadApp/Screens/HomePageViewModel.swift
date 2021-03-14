//
//  HomeViewModel.swift
//  BreakingBadProject
//
//  Created by Melvin Asare on 12/03/2021.
//

import Foundation

class HomePageViewModel {

    public var characters: [Character] = []
    public var filteredCharacters: [Character] = []
    public var isSearching: Bool = false

    func fetchCharacterData(_ completion: @escaping ([Character]) -> Void) {
        NetworkManager.shared.fetchCharacterData { charactersData in
            self.characters = charactersData
            completion(self.characters)
        }
    }
}
