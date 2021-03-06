//
//  FavoriteView.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 13/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var presenter: FavoritePresenter
    
    var body: some View {
        VStack {
            Group {
                if presenter.loadingState {
                    Loader()
                } else {
                    if presenter.games.isEmpty {
                        EmptyListView()
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(
                                self.presenter.games,
                                id: \.id
                            ) { game in
                                ZStack {
                                    self.presenter.linkBuilder(for: game) {
                                        GameRowView(game: game)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } .onAppear {
            self.presenter.getFavGames()
        }
        .navigationBarTitle("Favorite", displayMode: .inline)
    }
}
