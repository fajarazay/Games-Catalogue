//
//  GamesResponse.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation

struct GamesResponse: Decodable {

  let results: [GameResponse]
      
    init(games : [GameResponse]) {
      self.results = games
    }
    enum CodingKeys: String, CodingKey {
      case results = "results"
    }
}

struct GameResponse: Decodable {

  private enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case backgroundImage = "background_image"
  }
    let id: Int
    let name: String?
    let backgroundImage: String?
  
}
