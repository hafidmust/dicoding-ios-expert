//
//  expert1App.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 27/03/25.
//

import SwiftUI

@main
struct expert1App: App {
    let viewModel = AppModule.shared.container.resolve(GameListViewModel.self)
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
