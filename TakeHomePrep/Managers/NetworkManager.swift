//
//  NetworkManager.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-06-15.
//

import UIKit

class NetworkManager {
    static let shared   = NetworkManager()
    private let baseURL = "https://api.github.com"
    let cache           = NSCache<NSString, UIImage>()
    let itemsPerPage    = 50

    private init() {}

    func getFollowers(for username: String,
                      page: Int,
                      completed: @escaping (Result<[Follower], IZError>) -> Void) {
        let endpoint = baseURL + "/users/\(username)/followers?per_page=\(itemsPerPage)&page=\(page)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder                         = JSONDecoder()
                decoder.keyDecodingStrategy         = .convertFromSnakeCase
                decoder.dateDecodingStrategy        = .iso8601
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.decoderFailure))
            }
        }

        task.resume()
    }

    func getUserInfo(for username: String,
                      completed: @escaping (Result<User, IZError>) -> Void) {
        let endpoint = baseURL + "/users/\(username)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder                     = JSONDecoder()
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dateDecodingStrategy    = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.decoderFailure))
                return
            }
        }

        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}
