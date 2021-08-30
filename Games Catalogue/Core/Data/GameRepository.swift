//
//  GameRepository.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation
import Combine

protocol GameRepositoryProtocol {
    
    func getGames() -> AnyPublisher<[GameModel], Error>
    func getFavGames() -> AnyPublisher<[GameModel], Error>
    func getGameDetail(gameId: Int) -> AnyPublisher<GameModel, Error>
    func setFavorite(game: GameModel) -> AnyPublisher<Bool, Error>
    func setUnfavorite(game: GameModel) -> AnyPublisher<Bool, Error> 
}

final class GameRepository: NSObject {
    
    typealias GameInstance = (LocaleDataSource, RemoteDataSource) -> GameRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let sharedInstance: GameInstance = { localeRepo, remoteRepo in
        return GameRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension GameRepository: GameRepositoryProtocol {
    func getFavGames() -> AnyPublisher<[GameModel], Error> {
        return self.locale.getFavGames()
            .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func setFavorite(game: GameModel) -> AnyPublisher<Bool, Error> {
        return self.locale.setFavorite(from: GameMapper.mapGameDomainToEntity(input: game))
            .eraseToAnyPublisher()
    }
    
    func setUnfavorite(game: GameModel) -> AnyPublisher<Bool, Error> {
        return self.locale.setUnfavorite(from: GameMapper.mapGameDomainToEntity(input: game))
            .eraseToAnyPublisher()
    }
    
    func getGameDetail(gameId: Int) -> AnyPublisher<GameModel, Error> {
        return self.locale.getGameDetail(gameId: gameId)
            .flatMap { result -> AnyPublisher<GameModel, Error> in
                if result.desc.isEmpty {
                    return self.remote.getDetailGame(gameId: gameId)
                        .map { GameMapper.mapGameDetailResponseToEntity(input: $0)}
                        .flatMap { self.locale.addGameDetail(from: $0) }
                        .flatMap { _ in self.locale.getGameDetail(gameId: gameId)
                            .map {GameMapper.mapGameDetailEntityToDomain(input: $0)}
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getGameDetail(gameId: gameId)
                        .map { GameMapper.mapGameDetailEntityToDomain(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getGames() -> AnyPublisher<[GameModel], Error> {
        
        return self.locale.getGames()
            .flatMap { result -> AnyPublisher<[GameModel], Error> in
                
                if result.isEmpty {
                    return self.remote.getGames()
                        .map { GameMapper.mapGameResponsesToEntities(input: $0) }
                        .flatMap { self.locale.addGames(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getGames()
                            .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getGames()
                        .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
