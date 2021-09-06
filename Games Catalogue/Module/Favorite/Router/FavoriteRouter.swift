//
//  FavoriteRouter.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 29/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI
import Cleanse

class FavoriteRouter {
    let detailUseCase: Factory<DetailInteractor.AssistedSeed>
    
    init(detailUseCase: Factory<DetailInteractor.AssistedSeed>) {
        self.detailUseCase = detailUseCase
    }
    
    func makeDetailView(for game: GameModel) -> some View {
        let presenter = DetailPresenter(detailUseCase: detailUseCase.build(game))
        return DetailView(detailPresenter: presenter)
    }
}

extension FavoriteRouter {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.include(module: DetailInteractor.Module.self)
            binder.bind(FavoriteRouter.self).to(factory: FavoriteRouter.init)
        }
    }
}
