//
//  FavoriteViewModel.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 29/03/25.
//

import Combine
import Foundation

class FavoriteViewModel : ObservableObject {
    private let getFavoritesUseCase: GetFavoriteUseCaseProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var favorites: [Game] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init(getFavoritesUseCase: GetFavoriteUseCaseProtocol) {
        self.getFavoritesUseCase = getFavoritesUseCase
    }
    
    func fetchFavorites() {
        isLoading = true
        getFavoritesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] games in
                self?.favorites = games
            })
            .store(in: &cancellables)
    }
}
