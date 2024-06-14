//
//  NameViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 08/06/24.
//

import Foundation

class NameViewModel {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func enviarEmailSenhaConfirmarSenhaENomePraProximaTela(nome: String) {
        user.nome = nome
        print("DEBUG: Nome foi cadastrado \(user.nome)")
        print("DEBUG: Objeto EMAIL: \(user.email), SENHA: \(user.senha), CONFIRMA SENHA: \(user.confirmaSenha), NOME: \(user.nome)")
        print("DEBUG: CADASTRO FINALIZADO COM SUCESSO!")
        let repository = Repository()
        repository.save(user: user)
    }
}
