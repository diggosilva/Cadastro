//
//  PasswordViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import Foundation

class PasswordViewModel {
    var cadastro: Cadastro?
    var email: String = ""
    var senha: String = ""
    
    init(email: String) {
        self.email = email
    }
    
    init(cadastro: Cadastro?) {
        self.cadastro = cadastro
    }
    
    func enviarEmailESenhaPraProximaTela(senha: String) {
        self.senha = senha
        print("DEBUG: Email cadastrado: \(self.email)")
        print("DEBUG: Senha cadastrada: \(self.senha)")
        print("DEBUG: \(Cadastro(email: email, senha: senha))")
    }
}