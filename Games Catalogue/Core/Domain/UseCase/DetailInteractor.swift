//
//  DetailInteractor.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Combine

protocol DetailUseCase {
    
    func getGameDetail(gameId: Int) -> AnyPublisher<GameModel, Error>
    
    func getGame() -> GameModel
    
    func setFavorite(game: GameModel) -> AnyPublisher<Bool, Error>
    
    func setUnfavorite(game: GameModel) -> AnyPublisher<Bool, Error>

}

class DetailInteractor: DetailUseCase {
    
    private let repository: GameRepositoryProtocol
    private let game: GameModel
    
    required init(
        repository: GameRepositoryProtocol,
        game: GameModel
    ) {
        self.repository = repository
        self.game = game
    }
    
    func getGameDetail(gameId: Int) -> AnyPublisher<GameModel, Error> {
        return repository.getGameDetail(gameId: gameId)
    }
    
    func getGame() -> GameModel {
        return game
    }
    
    func setFavorite(game: GameModel) -> AnyPublisher<Bool, Error> {
        return repository.setFavorite(game: game)
    }
    
    func setUnfavorite(game: GameModel) -> AnyPublisher<Bool, Error> {
        return repository.setUnfavorite(game: game)
    }
    
}
