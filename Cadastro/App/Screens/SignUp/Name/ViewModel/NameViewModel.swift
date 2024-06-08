//
//  NameViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 08/06/24.
//

import Foundation

class NameViewModel {
    var cadastro: Cadastro?
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var nome: String = ""
    
    init(email: String, password: String, confirmPassword: String) {
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
    
    init(cadastro: Cadastro?) {
        self.cadastro = cadastro
    }
    
    func enviarEmailSenhaConfirmarSenhaENomePraProximaTela(nome: String) {
        self.nome = nome
        print("DEBUG: Email cadastrado: \(self.email)")
        print("DEBUG: Senha cadastrada: \(self.password)")
        print("DEBUG: Confirmar Senha cadastrada: \(self.confirmPassword)")
        print("DEBUG: \(Cadastro(email: self.email, senha: self.password, confirmaSenha: self.confirmPassword, nome: nome))")
        print("CADSTRO FINALIZADO COM SUCESSO!")
    }
}
