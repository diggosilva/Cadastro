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
        user.nome = nome
        repository.save(user: user)
        print("DEBUG: Usuário cadastrado -> EMAIL: \(self.user.email), SENHA: \(self.user.senha), CONFIRMA SENHA: \(self.user.confirmaSenha), NOME: \(self.user.nome)")
    }
}
