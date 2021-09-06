//
//  RemoteDataSource.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation
import Alamofire
import Combine
import Cleanse

protocol RemoteDataSourceProtocol: AnyObject {
    
    func getGames() -> AnyPublisher<[GameResponse], Error>
    
    func getDetailGame(gameId: Int) -> AnyPublisher<GameResponse, Error>
}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getDetailGame(gameId: Int) -> AnyPublisher<GameResponse, Error> {
        return Future<GameResponse, Error> { completion in
            if let url = URL(string: Endpoints.Gets.detailGame(idGame: gameId).url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getGames() -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.listGames.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}

extension RemoteDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(RemoteDataSource.self).to(factory: RemoteDataSource.init)
        }
    }
}
