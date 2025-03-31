//
//  GetDetailGameUseCase.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 28/03/25.
//
import Combine

protocol GetDetailGameUseCaseProtocol {
    func execute(id: Int) -> AnyPublisher<Game, Error>
}

class GetDetailGameUseCase: GetDetailGameUseCaseProtocol {
    
    
    private let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) -> AnyPublisher<Game, any Error> {
        return repository.getDetailGame(id: id)
    }
    
}

