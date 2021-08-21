//
//  GameDetailModel.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 20/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation

struct GameDetailModel: Equatable, Identifiable {
    let id: Int? = 0
    let name: String? = ""
    let backgroundImage: String? = ""
    let releasedDate: String? = ""
    let rating: Double? = 0
    let genres: [GenreModel]? = []
    let platforms: [PlatformModel]? = []
    let description: String? = ""
}
