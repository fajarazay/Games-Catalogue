//
//  HomePresenter.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI
import Combine
import Cleanse

class HomePresenter: ObservableObject {
    
    private let router: HomeRouter
    private let homeUseCase: HomeUseCase
    
    @Published var games: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase, homeRouter: HomeRouter) {
        self.homeUseCase = homeUseCase
        self.router = homeRouter
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func getGames() {
        loadingState = true
        errorMessage = ""
        homeUseCase.getGames()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                    self.loadingState = false
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

extension HomePresenter {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: HomeInteractor.Module.self)
            binder.include(module: HomeRouter.Module.self)
            binder.bind(HomePresenter.self).to(factory: HomePresenter.init)
        }
    }
}
