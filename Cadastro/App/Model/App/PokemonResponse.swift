//
//  FeedResponse.swift
//  Cadastro
//
//  Created by Diggo Silva on 20/06/24.
//

import Foundation

struct PokemonResponse: Codable {
    let next: String?
    let results: [NameURLModel]
    
    struct NameURLModel: Codable {
        let name: String
        let url: String
    }
}
