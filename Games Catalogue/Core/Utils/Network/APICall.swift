//
//  APICall.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 11/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation

struct API {
    
    static let baseUrl = "https://api.rawg.io/api/"
    static let key = "4645a4ddcf264e12be1ad92c98125588"
    
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case listGames
        
        public var url: String {
            switch self {
            case .listGames : return "\(API.baseUrl)games?key=\(API.key)"
            }
        }
    }
    
}
