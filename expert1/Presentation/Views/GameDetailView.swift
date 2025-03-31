//
//  GameDetailView.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 28/03/25.
//

import Foundation

import SwiftUI
struct GameDetailView : View {
    @ObservedObject var viewModel: GameDetailViewModel
        let gameId: Int
    
    @State private var hideTabBar: Bool = false
    
        var body: some View {
            ScrollView(.vertical, showsIndicators: true) {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let game = viewModel.dataDetail {
                    LazyVStack() {
                        AsyncImage(url: URL(string: game.backgroundImage)) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 250)
                        .clipped()

                        HStack(
                            alignment: .center
                        ) {
                            Text(game.name)
                                .font(.title)
                                .bold()
                                .padding(.top, 8)
                            Spacer()
                            Button(
                                action: {
                                    if viewModel.isFavorite {
                                        viewModel.removeFavorite(game: game)
                                    
                                    }else {
                                        viewModel.addFavorite(game: game)
                                    }
                                }
                            ){
                                Image(
                                    systemName: viewModel.isFavorite ? "heart.fill" : "heart"
                                )
                                .foregroundColor(viewModel.isFavorite ? .red : .gray)
                                                .font(.system(size: 20))
                                                .animation(.easeInOut(duration: 0.2), value: viewModel.isFavorite)
                            }
                            
                            .buttonStyle(PlainButtonStyle())
                        }

                        HStack {
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                            Text("\(game.rating, specifier: "%.1f")")
                                .font(.headline)
                            Spacer()
                            Text("Released: \(game.release)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 4)

                        Divider().padding(.vertical, 8)
                        
                        Text(viewModel.parsedDescription ?? "")
                            .font(.body)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 50)
                } else {
                    Text(viewModel.errorMessage ?? "Game data not available.")
                        .foregroundColor(.red)
                }
            }
            .onAppear {
                viewModel.fetchDetailGame(id: gameId)
                if let description = viewModel.dataDetail?.description {
                    viewModel.parseHTMLDescription(description)
                }
                viewModel.checkFavorite(id: gameId)
                hideTabBar = true
            }
            .onDisappear{
                hideTabBar = false
            }
            .navigationTitle("Game Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(hideTabBar ? .hidden : .visible, for: .tabBar)
            .animation(.easeInOut(duration: 0.3), value: hideTabBar)
        }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(viewModel: GameDetailViewModel(
            getDetailGameUseCase: GetDetailGameUseCase(repository: GameRepository(
                remoteDataSource: RemoteDataSource(),
                localDataSource: LocalDataSource())),
            addFavoriteGameUseCase: AddFavoriteUseCase(repository: GameRepository(remoteDataSource: RemoteDataSource(),                               localDataSource: LocalDataSource())),
            removeFavoriteGame: RemoveFavoriteUseCase(repository: GameRepository(remoteDataSource: RemoteDataSource(),localDataSource: LocalDataSource())), getfavoriteGameUseCase: GetFavoriteUseCase(repository:GameRepository(remoteDataSource: RemoteDataSource(),localDataSource: LocalDataSource()))
        ), gameId: 1)
    }
}
