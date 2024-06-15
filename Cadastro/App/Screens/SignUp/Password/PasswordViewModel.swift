//
//  PasswordViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import Foundation

class PasswordViewModel {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func enviarEmailESenhaPraProximaTela(senha: String) {
        user.senha = senha
    }
}
