//
//  AppModule.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 27/03/25.
//

import Swinject


class AppModule {
    static let shared = AppModule()
    
    let container : Container
    
    
    private init(){
        container = Container()
        
        //register remote datasource
        container.register(RemoteDataSourceProtocol.self){ _ in RemoteDataSource()}
        //register local datasource
        container.register(LocalDataSourceProtocol.self){ _ in LocalDataSource()}
        
        //register repo
        container.register(GameRepositoryProtocol.self){ r in
            GameRepository(remoteDataSource: r.resolve(RemoteDataSourceProtocol.self)!, localDataSource: r.resolve(LocalDataSourceProtocol.self)!)
        }
        
        //register usecase
        container.register(GetGamesUseCaseProtocol.self){ r in
            GetGameUseCase(repository: r.resolve(GameRepositoryProtocol.self)!)
        }
        container.register(GetDetailGameUseCaseProtocol.self){ r in
            GetDetailGameUseCase(repository: r.resolve(GameRepositoryProtocol.self)!)
        }
        container.register(GetFavoriteUseCaseProtocol.self){ r in
            GetFavoriteUseCase(repository: r.resolve(GameRepositoryProtocol.self)!)
        }
        container.register(AddFavoriteUseCaseProtocol.self){ r in
            AddFavoriteUseCase(repository: r.resolve(GameRepositoryProtocol.self)!)
        }
        container.register(RemoveFavoriteUseCaseProtocol.self){ r in
            RemoveFavoriteUseCase(repository: r.resolve(GameRepositoryProtocol.self)!)
        }
        //regiser viewmodel
        container.register(GameListViewModel.self){ r in
            GameListViewModel(getGamesUseCase: r.resolve(GetGamesUseCaseProtocol.self)!)
        }
        container.register(GameDetailViewModel.self){ r in
            GameDetailViewModel(
                getDetailGameUseCase: r.resolve(GetDetailGameUseCaseProtocol.self)!,
                addFavoriteGameUseCase: r.resolve(AddFavoriteUseCaseProtocol.self)!,
                removeFavoriteGame: r.resolve(RemoveFavoriteUseCaseProtocol.self)!,
                getfavoriteGameUseCase: r.resolve(GetFavoriteUseCaseProtocol.self)!
            )
        }
    }
    
    func resolve<T>(_ type: T.Type) -> T {
            return container.resolve(T.self)!
        }
}
