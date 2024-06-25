//
//  User.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import Foundation

class User: Codable, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.email == rhs.email &&
        lhs.senha == rhs.senha &&
        lhs.confirmaSenha == rhs.confirmaSenha &&
        lhs.nome == rhs.nome &&
        lhs.favoritePokemons == rhs.favoritePokemons &&
        lhs.id == rhs.id
    }
    
    var email: String = ""
    var senha: String = ""
    var confirmaSenha: String = ""
    var nome: String = ""
    var favoritePokemons: [Int] = []
    var id: Int
}
