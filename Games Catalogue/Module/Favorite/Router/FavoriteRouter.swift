//
//  FavoriteRouter.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 29/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI

class FavoriteRouter {
    
    func makeDetailView(for game: GameModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(game: game)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(detailPresenter: presenter)
    }
    
}
