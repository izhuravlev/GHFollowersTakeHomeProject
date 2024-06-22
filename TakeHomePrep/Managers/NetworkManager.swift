//
//  NetworkManager.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-06-15.
//

import UIKit

class NetworkManager {
    static let shared   = NetworkManager()
    private let baseURL         = "https://api.github.com"
    let cache           = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username: String,
                      page: Int,
                      completed: @escaping (Result<[Follower], IZError>) -> Void) {
        let endpoint = baseURL + "/users/\(username)/followers?per_page=50&page=\(page)"
        
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
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.decoderFailure))
                return
            }
        }
        
        task.resume()
    }
    
    
}
