//
//  RemoveFavoriteUseCase.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 29/03/25.
//

import Combine

protocol RemoveFavoriteUseCaseProtocol {
    func execute(game: Game) -> AnyPublisher<Void, Error>
}

class RemoveFavoriteUseCase: RemoveFavoriteUseCaseProtocol {
    private let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(game: Game) -> AnyPublisher<Void, any Error> {
        return repository.removeFavorite(game: game)
    }
}
