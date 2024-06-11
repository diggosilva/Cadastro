//
//  ConfirmPasswordViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import Foundation

class ConfirmPasswordViewModel {
    var cadastro: Cadastro
    
    init(cadastro: Cadastro) {
        self.cadastro = cadastro
    }
    
    func enviarEmailSenhaEConfirmarSenhaPraProximaTela(confirmaSenha: String) {
        if confirmaSenha == cadastro.senha {
            cadastro.confirmaSenha = confirmaSenha
            print("DEBUG: Confirmação de Senha foi cadastrada: \(cadastro.confirmaSenha)")
        } else {
            print("DEBUG: Erro ao confirmar senha: A senha deve ser a mesma que você digitou anteriormente")
        }
    }
}
