//
//  FavoritePresenter.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 29/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
    
    private let router = FavoriteRouter()
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var games: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func getFavGames() {
        loadingState = true
        favoriteUseCase.getFavGames()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    print(completion)
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
