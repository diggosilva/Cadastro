//
//  NameViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 08/06/24.
//

import Foundation

class NameViewModel {
    var cadastro: Cadastro
    
    init(cadastro: Cadastro) {
        self.cadastro = cadastro
    }
    
    func enviarEmailSenhaConfirmarSenhaENomePraProximaTela(nome: String) {
        cadastro.nome = nome
        print("DEBUG: Nome foi cadastrado \(cadastro.nome)")
        print("DEBUG: Objeto EMAIL: \(cadastro.email), SENHA: \(cadastro.senha), CONFIRMA SENHA: \(cadastro.confirmaSenha), NOME: \(cadastro.nome)")
        print("DEBUG: CADASTRO FINALIZADO COM SUCESSO!")
    }
}
