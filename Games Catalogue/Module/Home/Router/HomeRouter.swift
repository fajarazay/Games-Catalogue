//
//  HomeRouter.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI
import Cleanse

class HomeRouter {
    
    let detailUseCase: Factory<DetailInteractor.AssistedSeed>

    init(detailUseCase: Factory<DetailInteractor.AssistedSeed>) {
        self.detailUseCase = detailUseCase
    }
    
    func makeDetailView(for game: GameModel) -> some View {
        let presenter = DetailPresenter(detailUseCase: detailUseCase.build(game))
        return DetailView(detailPresenter: presenter)
    }
}

extension HomeRouter {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: DetailInteractor.Module.self)
            binder.bind(HomeRouter.self).to(factory: HomeRouter.init)
        }
    }
}
