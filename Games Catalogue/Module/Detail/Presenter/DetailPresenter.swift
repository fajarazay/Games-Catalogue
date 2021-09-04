//
//  DetailPresenter.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI
import Combine
import Cleanse

class DetailPresenter: ObservableObject {
    
    private let detailUseCase: DetailUseCase
    
    @Published var game: GameModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var isFavoriteGame: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        self.game = detailUseCase.getGame()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func getGameDetail(gameId: Int) {
        loadingState = true
        detailUseCase.getGameDetail(gameId: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    print("failure \(completion)")
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { result in
                self.game = result
                self.isFavoriteGame = result.isFavorite
            })
            .store(in: &cancellables)
    }
    
    func setFavorite(game: GameModel) {
        detailUseCase.setFavorite(game: game)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    print("failure \(completion)")
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { value in
                self.isFavoriteGame = value
            })
            .store(in: &cancellables)
    }
    
    func setUnfavorite(game: GameModel) {
        detailUseCase.setUnfavorite(game: game)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    print("failure \(completion)")
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { value in
                self.isFavoriteGame = !value
            })
            .store(in: &cancellables)
    }
}

extension DetailPresenter {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: DetailInteractor.Module.self)
            binder.bind(DetailPresenter.self).to(factory: DetailPresenter.init)
        }
    }
}
