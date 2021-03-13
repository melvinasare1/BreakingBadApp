//
//  HomeViewModel.swift
//  BreakingBadProject
//
//  Created by Melvin Asare on 12/03/2021.
//

import Foundation

class HomePageViewModel {

    public var characters: [Character] = []

    init() {
        fetchCharacterData()
    }

    func fetchCharacterData() {
        NetworkManager.shared.fetchCharacterData { [weak self] charactersData in
            guard let self = self else { return }
            self.characters = charactersData
            print(self.characters)
        }
    }
    
}
