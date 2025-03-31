//
//  RemoteDataSource.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 27/03/25.
//

import Foundation
import Combine
import Alamofire

protocol RemoteDataSourceProtocol {
    func fetchGamess() -> AnyPublisher<ItemResponse, Error>
    func fetchGameDetail(id: Int) -> AnyPublisher<DetailResponse, Error>
}

class RemoteDataSource : RemoteDataSourceProtocol {
    
    
    private let baseURL = "https://api.rawg.io/api"
    
    func fetchGamess() -> AnyPublisher<ItemResponse, any Error> {
        let url = "\(baseURL)/games?key=6257b832b1614d97872a6973943fbbce"
        
        return Future<ItemResponse, Error> { promise in
            AF.request(url)
                .validate()
                .responseDecodable(of: ItemResponse.self){ response in
                    switch response.result {
                    case .success(let items):
                        promise(.success(items))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }.eraseToAnyPublisher()
    }
    
    func fetchGameDetail(id: Int) -> AnyPublisher<DetailResponse, any Error> {
        let url = "\(baseURL)/games/\(id)?key=6257b832b1614d97872a6973943fbbce"
        return Future<DetailResponse, Error> { promise in
            AF.request(url)
                .validate()
                .responseDecodable(of: DetailResponse.self){ response in
                    switch response.result {
                    case .success(let data):
                        promise(.success(data))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }.eraseToAnyPublisher()

    }
}
