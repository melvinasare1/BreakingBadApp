//
//  NetworkManager.swift
//  BreakingBadProject
//
//  Created by Melvin Asare on 12/03/2021.
//

import Alamofire

class NetworkManager {

    static let shared = NetworkManager()

    func fetchCharacterDataAlamofire(_ completion: @escaping ([Character]) -> Void) {
        AF.request("https://breakingbadapi.com/api/characters")
            .responseData { response in
                completion(response)
            }
    }


    func fetchCharacterData(_ completion: @escaping ([Character]) -> Void) {
        let endpoint = "https://breakingbadapi.com/api/characters"

        guard let url = URL(string: endpoint) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data
            else { return }

            do {
                let decoder = JSONDecoder()
                let character = try decoder.decode([Character].self, from: data)
                completion(character)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
