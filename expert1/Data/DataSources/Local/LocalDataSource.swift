//
//  LocalDataSource.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 29/03/25.
//


import CoreData
import Combine

protocol LocalDataSourceProtocol {
    func addFavorite(game: Game) -> AnyPublisher<Void, Error>
    func removeFavorite(game: Game) -> AnyPublisher<Void, Error>
    func getFavorites() -> AnyPublisher<[Game], Error>
    func isFavorite(id: Int) -> AnyPublisher<Bool, Error>
}

class LocalDataSource : LocalDataSourceProtocol {
    
    
    private let context = CoreDataManager.shared.context
    
    func getFavorites() -> AnyPublisher<[Game], any Error> {
        return Future<[Game], Error> { promise in
                    let request: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
                    do {
                        let results = try self.context.fetch(request)
                        let items = results.map {
                            Game(
                                id: Int($0.id),
                                name: $0.name ?? "",
                                backgroundImage: $0.backgroundImage ?? "",
                                release: $0.released ?? "",
                                rating: $0.rating,
                                description: $0.desc ?? ""
                            )
                        }
                        promise(.success(items))
                    } catch {
                        promise(.failure(error))
                    }
                }.eraseToAnyPublisher()
    }
    
    func addFavorite(game: Game) -> AnyPublisher<Void, any Error> {
        return Future<Void, Error> { completion in
            let favoriteGame = FavoriteItem(context: self.context)
            favoriteGame.id = Int64(game.id)
            favoriteGame.name = game.name
            favoriteGame.released = game.release
            favoriteGame.backgroundImage = game.backgroundImage
            favoriteGame.rating = game.rating
            favoriteGame.desc = game.description
            
            do {
                try self.context.save()
                completion(.success(()))
            
            }catch {
                completion(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func removeFavorite(game: Game) -> AnyPublisher<Void, any Error> {
        return Future<Void, Error> { completion in
            let request: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", game.id)
            do {
                let favoriteGame = try self.context.fetch(request)
                for item in favoriteGame {
                    self.context.delete(item)
                }
                try self.context.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
            
        }.eraseToAnyPublisher()
    }
    
    func isFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let request: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", id)
            
            do {
                let count = try self.context.count(for: request)
                completion(.success(count > 0))
            
            } catch {
                completion(.failure(error))
            }
            
        }.eraseToAnyPublisher()
    }
}
