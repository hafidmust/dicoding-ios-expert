//
//  MainTabView.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 27/03/25.
//


import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            GameListView(viewModel: GameListViewModel(getGamesUseCase: AppModule.shared.container.resolve(GetGamesUseCaseProtocol.self)!))
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            FavoriteView(
                viewModel: FavoriteViewModel(
                    getFavoritesUseCase: AppModule.shared.container.resolve(GetFavoriteUseCaseProtocol.self)!
                )
            )
            .tabItem {
                Label("Favorites", systemImage: "star.fill")
            }
            
            AboutView()
                .tabItem {
                    Label("About", systemImage: "person.fill")
                }
            
        }
    }
}
