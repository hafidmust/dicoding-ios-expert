//
//  GameDetailViewModel.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 28/03/25.
//

import Foundation
import Combine

class GameDetailViewModel : ObservableObject {
    private let getDetailGameUseCase: GetDetailGameUseCaseProtocol
    private let addFavoriteGameUseCase: AddFavoriteUseCaseProtocol
    private let removeFavoriteGameUseCase: RemoveFavoriteUseCaseProtocol
    private let getFavoriteGameUseCase: GetFavoriteUseCaseProtocol
    private var cancellable: Set<AnyCancellable> = []
    
    @Published var dataDetail: Game? = nil
    @Published var isFavorite = false
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var parsedDescription: AttributedString?
    
    init(getDetailGameUseCase: GetDetailGameUseCaseProtocol, addFavoriteGameUseCase: AddFavoriteUseCaseProtocol, removeFavoriteGame: RemoveFavoriteUseCaseProtocol, getfavoriteGameUseCase: GetFavoriteUseCaseProtocol) {
        self.getDetailGameUseCase = getDetailGameUseCase
        self.addFavoriteGameUseCase = addFavoriteGameUseCase
        self.removeFavoriteGameUseCase = removeFavoriteGame
        self.getFavoriteGameUseCase = getfavoriteGameUseCase
    }
    
    func fetchDetailGame(id: Int) {
        isLoading = true
        getDetailGameUseCase.execute(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { items in
                self.dataDetail = items
//                self.isFavorite = self.checkFavorite(id: items.id)
            })
            .store(in: &cancellable)
    }
    
    func addFavorite(game: Game) {
        guard let dataDetail = dataDetail else { return }
        addFavoriteGameUseCase.execute(game: game)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { _ in
                self.isFavorite = true
            })
            .store(in: &cancellable)
    }
    
    func removeFavorite(game: Game) {
        guard let dataDetail = dataDetail else { return }
        removeFavoriteGameUseCase.execute(game: game)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { _ in
                self.isFavorite = false
            })
            .store(in: &cancellable)
    }
    
    func checkFavorite(id: Int) {
        getFavoriteGameUseCase.isFavorite(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] isFavorite in
                self?.isFavorite = isFavorite
            })
            .store(in: &cancellable)
    }
    
    func parseHTMLDescription(_ html: String) {
            DispatchQueue.global(qos: .userInitiated).async {
                if let attributedString = self.htmlToAttributedString(html) {
                    DispatchQueue.main.async {
                        self.parsedDescription = attributedString
                    }
                }
            }
        }
    
    func htmlToAttributedString(_ html: String) -> AttributedString? {
            guard let data = html.data(using: .utf8) else { return nil }
            do {
                let attributedString = try NSAttributedString(
                    data: data,
                    options: [.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil
                )
                return AttributedString(attributedString)
            } catch {
                print("Error parsing HTML: \(error)")
                return nil
            }
        }
}
