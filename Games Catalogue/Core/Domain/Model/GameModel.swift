//
//  GameModel.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation

struct GameModel: Equatable, Identifiable {
    let id: Int
    let name: String
    let backgroundImage: String
    let releasedDate: String
    let rating: Double
    let genres: [GenreModel]
    let platforms: [PlatformModel]
}

struct GenreModel: Equatable, Identifiable {
    let id: Int?
    let name: String?
}

struct PlatformModel: Equatable, Identifiable {
    let id: Int?
    let name: String?
}
