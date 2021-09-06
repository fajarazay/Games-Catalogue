//
//  FavoriteInteractor.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 29/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation
import Combine
import Cleanse

protocol FavoriteUseCase {
    
    func getFavGames() -> AnyPublisher<[GameModel], Error>
    
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavGames() -> AnyPublisher<[GameModel], Error> {
        return repository.getFavGames()
    }
    
}

extension FavoriteInteractor {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: GameRepository.Module.self)
            binder.bind(FavoriteUseCase.self).to(factory: FavoriteInteractor.init)
            binder.bind(FavoriteInteractor.self).to(factory: FavoriteInteractor.init)
        }
    }
}
