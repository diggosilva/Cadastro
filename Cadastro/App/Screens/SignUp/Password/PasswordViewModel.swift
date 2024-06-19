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
    
    func isPasswordValid(_ password: String?) -> Bool {
        guard let password = password else { return false }
        
        // Verifica se a senha não está vazia e atende aos critérios mínimos de segurança
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{4,}$"
        let passwordValid = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return passwordValid.evaluate(with: password)
    }
    
    func goToNextStep(senha: String) {
        user.senha = senha
    }
}
