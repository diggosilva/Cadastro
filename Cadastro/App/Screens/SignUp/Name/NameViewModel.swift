//
//  NameViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 08/06/24.
//

import Foundation

class NameViewModel {
    var user: User
    let repository = Repository()
    
    init(user: User) {
        self.user = user
    }
    
    func enviarEmailSenhaConfirmarSenhaENomePraProximaTela(nome: String) {
        let repository = Repository()
        repository.save(user: user)
    }
}
