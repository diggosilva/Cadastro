//
//  FeedModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 20/06/24.
//

import Foundation

struct Pokemon {
    let name: String
    let url: String
    var isSelected: Bool = false
    
    var imageUrl: String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(getId).png"
    }
    
    var typeUrl: String {
        return "https://pokeapi.co/api/v2/type/\(getId)"
    }
    
    var getId: Int {
        var id = url.components(separatedBy: "https://pokeapi.co/api/v2/pokemon/").last ?? ""
        id = String(id.dropLast())
        return Int(id) ?? 0
    }
}
