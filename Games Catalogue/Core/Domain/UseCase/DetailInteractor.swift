//
//  DetailInteractor.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Combine
import Cleanse

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
        game: Assisted<GameModel>
    ) {
        self.repository = repository
        self.game = game.get()
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

extension DetailInteractor {
    struct AssistedSeed: AssistedFactory {
        typealias Seed = GameModel
        typealias Element = DetailUseCase
    }
    struct Module: Cleanse.Module {
        public static func configure(binder: UnscopedBinder) {
            binder
                .bindFactory(DetailUseCase.self)
                .with(AssistedSeed.self)
                .to { (seed: Assisted<GameModel>, repository: Provider<GameRepository>) in
                    return DetailInteractor(repository: repository.get(), game: seed)
                }
        }
    }
}
