//
//  HomeInteractor.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Combine
import Cleanse

protocol HomeUseCase {
    
    func getGames() -> AnyPublisher<[GameModel], Error>
    
}

class HomeInteractor: HomeUseCase {
    
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGames() -> AnyPublisher<[GameModel], Error> {
        return repository.getGames()
    }
    
}

extension HomeInteractor {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: GameRepository.Module.self)
            binder.bind(HomeUseCase.self).to(factory: HomeInteractor.init)
            binder.bind(HomeInteractor.self).to(factory: HomeInteractor.init)
        }
    }
}
