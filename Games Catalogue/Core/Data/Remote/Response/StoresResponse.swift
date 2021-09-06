//
//  StoresResponse.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 21/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation

struct StoresResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case store
    }
    let store: StoreResponse?
}

struct StoreResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case domain
    }
    let id: Int?
    let name: String?
    let domain: String?
}
