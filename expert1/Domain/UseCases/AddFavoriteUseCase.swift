//
//  AddFavoriteUseCase.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 29/03/25.
//
import Combine

protocol AddFavoriteUseCaseProtocol {
    func execute(game: Game) -> AnyPublisher<Void, Error>
}

class AddFavoriteUseCase: AddFavoriteUseCaseProtocol {
   
    
    private let repository: GameRepositoryProtocol
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    func execute(game: Game) -> AnyPublisher<Void, Error> {
       return repository.addFavorite(game: game)
    }
}

