//
//  PlatformsResponse.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 17/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation

struct PlatformsResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case platform
    }
    let platform: PlatformResponse?
}

struct PlatformResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    let id: Int?
    let name: String?
}
