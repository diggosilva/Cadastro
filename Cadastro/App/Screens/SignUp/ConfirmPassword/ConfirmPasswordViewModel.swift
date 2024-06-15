//
//  ConfirmPasswordViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import Foundation

class ConfirmPasswordViewModel {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func enviarEmailSenhaEConfirmarSenhaPraProximaTela(confirmaSenha: String) {
        if confirmaSenha == user.senha {
            user.confirmaSenha = confirmaSenha
        } else {
            print("DEBUG: Erro ao confirmar senha: A senha deve ser a mesma que você digitou anteriormente")
        }
    }
}
