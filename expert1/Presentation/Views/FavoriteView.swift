//
//  FavoriteView.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 29/03/25.
//

import SwiftUI
import Swinject

struct FavoriteView: View {
    @StateObject var viewModel : FavoriteViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.favorites) { item in
                NavigationLink(destination: GameDetailView(viewModel: GameDetailViewModel(
                    getDetailGameUseCase: AppModule.shared.container.resolve(GetDetailGameUseCaseProtocol.self)!,
                    addFavoriteGameUseCase: AppModule.shared.container.resolve(AddFavoriteUseCaseProtocol.self)!,
                    removeFavoriteGame: AppModule.shared.container.resolve(RemoveFavoriteUseCaseProtocol.self)!,
                    getfavoriteGameUseCase: AppModule.shared.container.resolve(GetFavoriteUseCaseProtocol.self)!
                ), gameId: item.id)) {
                    HStack {
                        AsyncImage(url: URL(string: "\(item.backgroundImage)")) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Text("\(item.name)")
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("Favorites")
            .onAppear {
                viewModel.fetchFavorites()
            }
        }
    }
}
