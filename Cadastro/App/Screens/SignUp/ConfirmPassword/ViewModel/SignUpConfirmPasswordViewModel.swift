//
//  SignUpConfirmPasswordViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import Foundation

class SignUpConfirmPasswordViewModel {
    var cadastro: Cadastro?
    var email: String = ""
    var password: String = ""
    var confirmaSenha: String = ""
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    init(cadastro: Cadastro?) {
        self.cadastro = cadastro
    }
    
    func enviarEmailSenhaEConfirmarSenhaPraProximaTela(senha: String, confirmarSenha: String) {
        self.password = senha
        self.confirmaSenha = confirmarSenha
        
        if confirmarSenha == senha {
            print("Email cadastrado: \(self.email)")
            print("Senha cadastrada: \(self.password)")
            print("Confirmar Senha cadastrada: \(self.password)")
            print("DEBUG: \(Cadastro(email: email, senha: senha))")
        } else {
            print("Erro ao confirmar senha: A senha deve ser a mesma que você digitou anteriormente")
        }
    }
}
