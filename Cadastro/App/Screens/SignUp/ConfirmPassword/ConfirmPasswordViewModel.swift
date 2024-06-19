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
    
    func isConfirmPasswordValid(_ confirmPassword: String?) -> Bool {
        guard let confirmPassword = confirmPassword else { return false }
        
        // Verifica se a confirmação de senha é igual à senha original
        return confirmPassword == user.senha
    }
    
    func enviarConfirmacaoSenhaPraProximaTela(confirmaSenha: String) {
        if isConfirmPasswordValid(confirmaSenha) {
            user.confirmaSenha = confirmaSenha
        } else {
            print("DEBUG: Erro ao confirmar senha: A senha deve ser a mesma que você digitou anteriormente")
        }
    }
}
