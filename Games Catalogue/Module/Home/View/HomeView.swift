//
//  HomeView.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
      ZStack {
        if presenter.loadingState {
          VStack {
            ActivityIndicator()
          }
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            ForEach(
              self.presenter.games,
              id: \.id
            ) { game in
                ZStack {
                  self.presenter.linkBuilder(for: game) {
                    GameRowView(game: game)
                  }.buttonStyle(PlainButtonStyle())
                }.padding(8)
            }
          }
        }
      }.onAppear {
        if self.presenter.games.count == 0 {
          self.presenter.getGames()
        }
      }.navigationBarTitle(
        Text("Games Apps"),
        displayMode: .automatic
      )
    }
}
