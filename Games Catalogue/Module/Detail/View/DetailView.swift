//
//  DetailView.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
  @ObservedObject var presenter: DetailPresenter

  var body: some View {
    ZStack {
      if presenter.loadingState {
        loadingIndicator
      } else {
        ScrollView(.vertical) {
          VStack {
            imageGame
            spacer
            content
            spacer
          }.padding()
        }
      }
    }.navigationBarTitle(Text(self.presenter.game.name), displayMode: .large)
  }
}

extension DetailView {
  var spacer: some View {
    Spacer()
  }

  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }

  var imageGame: some View {
    WebImage(url: URL(string: self.presenter.game.backgroundImage))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .frame(width: 250.0, height: 250.0, alignment: .center)
  }

  var description: some View {
    Text(self.presenter.game.name)
      .font(.system(size: 15))
  }

  func headerTitle(_ title: String) -> some View {
    return Text(title)
      .font(.headline)
  }

  var content: some View {
    VStack(alignment: .leading, spacing: 0) {
      headerTitle("Description")
        .padding([.top, .bottom])
      description
    }
  }
}
