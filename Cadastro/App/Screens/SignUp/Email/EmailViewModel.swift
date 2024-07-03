//
//  EmailViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import Foundation

class EmailViewModel {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        
        // Remove espaços em branco no início e no fim do email
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Verifica se o email sem espaços em branco é válido com expressão regular
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailValid = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        let isEmailValid = emailValid.evaluate(with: trimmedEmail)
        
        // Verifica se o email original é igual ao email sem espaços em branco
        let isSameEmail = email == trimmedEmail
        
        return isEmailValid && isSameEmail
    }
    
    func goToNextStep(email: String) {
        user.email = email
    }
}
