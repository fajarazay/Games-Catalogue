//
//  FavoritePresenter.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 29/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI
import Combine
import Cleanse

class FavoritePresenter: ObservableObject {
    
    private let router: FavoriteRouter
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var games: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    
    init(favoriteUseCase: FavoriteUseCase, favoriteRouter: FavoriteRouter) {
        self.favoriteUseCase = favoriteUseCase
        self.router = favoriteRouter
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func getFavGames() {
        loadingState = true
        favoriteUseCase.getFavGames()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { games in
                self.games = games
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for game: GameModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: game)) { content() }
    }
    
}

extension FavoritePresenter {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: FavoriteInteractor.Module.self)
            binder.include(module: FavoriteRouter.Module.self)
            binder.bind(FavoritePresenter.self).to(factory: FavoritePresenter.init)
        }
    }
}
