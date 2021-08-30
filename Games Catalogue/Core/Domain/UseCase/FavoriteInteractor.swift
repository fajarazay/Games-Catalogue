//
//  FavoriteInteractor.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 29/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Combine

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
