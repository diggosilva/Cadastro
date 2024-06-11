//
//  PasswordViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import Foundation

class PasswordViewModel {
    var cadastro: Cadastro
    
    init(cadastro: Cadastro) {
        self.cadastro = cadastro
    }
    
    func enviarEmailESenhaPraProximaTela(senha: String) {
        cadastro.senha = senha
        print("DEBUG: Senha foi cadastrada: \(cadastro.senha)")
    }
}
