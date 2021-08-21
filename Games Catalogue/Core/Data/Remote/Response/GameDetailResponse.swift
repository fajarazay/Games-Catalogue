//
//  GameDetailResponse.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 17/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation

struct GameDetailResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case description
    }
    let description: String
    
}
