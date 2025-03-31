//
//  GameListViewModel.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 27/03/25.
//
import Foundation
import Combine

class GameListViewModel : ObservableObject {
    private let getGamesUseCase : GetGamesUseCaseProtocol
    private var cancellable: Set<AnyCancellable> = []
    
    @Published var games: [Game] = []
    //fav
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    init(getGamesUseCase: GetGamesUseCaseProtocol) {
        self.getGamesUseCase = getGamesUseCase
        //        self.isLoading = isLoading
        //        self.errorMessage = errorMessage
    }
    
    func fetchGames() {
        isLoading = true
        getGamesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { items in
                self.games = items
            })
            .store(in: &cancellable)
    }
}
