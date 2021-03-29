//
//  NetworkManager.swift
//  BreakingBadProject
//
//  Created by Melvin Asare on 12/03/2021.
//

import UIKit

class NetworkManager {

    static let shared = NetworkManager()
    public let cache = NSCache<NSString, UIImage>()
    public let endpoint = "https://breakingbadapi.com/api/characters"

    func fetchCharacterData(_ completion: @escaping ([Character]) -> Void) {

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

    func downloadCache(from urlString: String, imageView: UIImageView) {
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            imageView.image = image
            return
        }

        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil { return }

            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data)
            else { return }

            self.cache.setObject(image, forKey: cacheKey)

            DispatchQueue.main.async {

                imageView.image = image
            }
        }
        task.resume()
    }
}
