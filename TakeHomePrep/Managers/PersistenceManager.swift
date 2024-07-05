//
//  PersistenceManager.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-07-05.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favourites = "favourites"
    }
    
    static func updateWith(favourite: Follower, 
                           actionType: PersistenceActionType,
                           completed: @escaping (IZError?) -> Void) {
        retrieveFavourites { result in
            switch result {
            case .success( let favourites):
                var retrievedFavourites = favourites
                switch actionType {
                    
                case .add:
                    guard !retrievedFavourites.contains(favourite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retrievedFavourites.append(favourite)
                    
                case .remove:
                    retrievedFavourites.removeAll { $0.login == favourite.login}
                }
                
                completed(save(favourites: retrievedFavourites))
            case .failure( let error ):
                completed(error)
            }
        }
    }
    
    static func retrieveFavourites(completed: @escaping (Result<[Follower], IZError>) -> Void) {
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([Follower].self, from: favouritesData)
            completed(.success(favourites))
        } catch {
            completed(.failure(.unableToRetrieveFavourites))
        }
    }
    
    static func save(favourites: [Follower]) -> IZError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favourites)
            defaults.setValue(encodedFavourites, forKey: Keys.favourites)
            return nil
        } catch {
            return .unableToFavourite
        }
    }
}
