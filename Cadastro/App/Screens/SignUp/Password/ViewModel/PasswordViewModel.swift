//
//  PasswordViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import Foundation

class PasswordViewModel {
    private var cadastro: Cadastro?
    var email: String = ""
    private var senha: String = ""
    
    init(email: String) {
        self.email = email
    }
    
    init(cadastro: Cadastro?) {
        self.cadastro = cadastro
    }
    
    func enviarEmailESenhaPraProximaTela(senha: String) {
        self.senha = senha
        print("DEBUG: Senha cadastrada: \(self.senha)")
        print("DEBUG: \(Cadastro(email: email, senha: senha))")
    }
}
