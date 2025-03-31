//
//  GetGamesUseCase.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 27/03/25.
//

import Foundation
import Combine

protocol GetGamesUseCaseProtocol {
    func execute() -> AnyPublisher<[Game], Error>
}

class GetGameUseCase : GetGamesUseCaseProtocol {
    private let repository : GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    func execute() -> AnyPublisher<[Game],Error> {
        return repository.getGames()
    }
}
