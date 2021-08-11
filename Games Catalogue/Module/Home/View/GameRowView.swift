//
//  GameRow.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameRowView: View {

  var game: GameModel
  var body: some View {
    VStack {
      imageGame
      content
    }
    .frame(width: UIScreen.main.bounds.width - 32, height: 250)
    .background(Color.random.opacity(0.3))
    .cornerRadius(30)
  }

}

extension GameRowView {

  var imageGame: some View {
    WebImage(url: URL(string: game.backgroundImage))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .frame(width: 200)
      .cornerRadius(30)
      .padding(.top)
  }
  
  var content: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(game.name)
        .font(.title)
        .bold()
    
    }.padding(
      EdgeInsets(
        top: 0,
        leading: 16,
        bottom: 16,
        trailing: 16
      )
    )
  }

}

//struct CategoryRow_Previews: PreviewProvider {
//
//  static var previews: some View {
//    let meal = CategoryModel(
//      id: "1",
//      title: "Beef",
//      image: "https://www.themealdb.com/images/category/beef.png",
//      description: "Beef is the culinary name for meat from cattle, particularly skeletal muscle."
//    )
//    return CategoryRow(category: meal)
//  }
//
//}
