//
//  GetFavoriteUseCase.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 29/03/25.
//

import Combine

protocol GetFavoriteUseCaseProtocol {
    func execute() -> AnyPublisher<[Game], Error>
    func isFavorite(id: Int) -> AnyPublisher<Bool, Error>
}

class GetFavoriteUseCase: GetFavoriteUseCaseProtocol {
    private let repository: GameRepositoryProtocol
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[Game], any Error> {
        return repository.getFavorites()
    }
    
    func isFavorite(id: Int) -> AnyPublisher<Bool, any Error> {
        return repository.isFavorite(id: id)
    }
}
