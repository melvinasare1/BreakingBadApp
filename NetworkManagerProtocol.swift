//
//  NetworkManagerProtocol.swift
//  BreakingBadApp
//
//  Created by Melvin Asare on 28/03/2021.
//

import Foundation


protocol NetworkManagerProtocol {
    func fetchCharacterData(_ completion: @escaping ([String: Any]?, Error?) -> Void)
}
