//
//  GameModel.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation

struct GameModel: Equatable, Identifiable {
    var id: Int = 0
    var name: String = ""
    var backgroundImage: String = ""
    var releasedDate: String = ""
    var rating: Double = 0
    var description: String = ""
    var reviewsCount: Int = 0
    var genres: [GenreModel] = []
    var platforms: [PlatformModel] = []
    var publishers: [PublisherModel] = []
    var stores: [StoreModel] = []
}

struct GenreModel: Equatable, Identifiable {
    let id: Int?
    let name: String?
}

struct PlatformModel: Equatable, Identifiable {
    let id: Int?
    let name: String?
}

struct PublisherModel: Equatable, Identifiable {
    let id: Int?
    let name: String?
}

struct StoreModel: Equatable, Identifiable {
    let id: Int?
    let name: String?
    let domain: String?
}
