//
//  GameRepository.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 27/03/25.
//
import Combine


protocol GameRepositoryProtocol {
    func getGames() -> AnyPublisher<[Game], Error>
    func getDetailGame(id: Int) -> AnyPublisher<Game, Error>
    func addFavorite(game: Game) -> AnyPublisher<Void, Error>
    func removeFavorite(game: Game) -> AnyPublisher<Void, Error>
    func getFavorites() -> AnyPublisher<[Game], Error>
    func isFavorite(id: Int) -> AnyPublisher<Bool, Error>
}

class GameRepository : GameRepositoryProtocol {
    
    private let remoteDataSource : RemoteDataSourceProtocol
    private let localDataSource : LocalDataSourceProtocol
    
    init(remoteDataSource: RemoteDataSourceProtocol, localDataSource: LocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getGames() -> AnyPublisher<[Game], any Error> {
        return remoteDataSource.fetchGamess()
            .map { (response: ItemResponse) in
                return response.results?.map { (data : ResultGame) in
                    return Game(id: data.id ?? -1, name: data.name ?? "", backgroundImage: data.backgroundImage ?? "", release: data.released ?? "", rating: data.rating ?? 0.0, description: "")
                    
                } ?? []
            }.eraseToAnyPublisher()
    }
    
    func getDetailGame(id: Int) -> AnyPublisher<Game, any Error> {
        return remoteDataSource.fetchGameDetail(id: id)
            .map { (response: DetailResponse) in
                return Game(id: response.id ?? -1, name: response.name ?? "", backgroundImage: response.backgroundImage ?? "", release: response.released ?? "", rating: response.rating ?? 0.0, description: response.description ?? "")
            }.eraseToAnyPublisher()
    }
    
    func addFavorite(game: Game) -> AnyPublisher<Void, any Error> {
        return localDataSource.addFavorite(game: game)
    }
    
    func removeFavorite(game: Game) -> AnyPublisher<Void, any Error> {
        return localDataSource.removeFavorite(game: game)
    }
    
    func getFavorites() -> AnyPublisher<[Game], any Error> {
        return localDataSource.getFavorites()
    }
    
    func isFavorite(id: Int) -> AnyPublisher<Bool, any Error> {
        return localDataSource.isFavorite(id: id)
    }
}
