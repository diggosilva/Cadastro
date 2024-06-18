//
//  NameViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 08/06/24.
//

import Foundation

class NameViewModel {
    var user: User
    let repository = Repository()
    
    init(user: User) {
        self.user = user
    }
    
    func validarNome(nome: String) -> Bool {
        let nameRegex = "^[a-zA-Z]+( [a-zA-Z]+)*$" // Expressão regular para verificar letras e espaços apenas entre palavras
        let nameValid = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return nameValid.evaluate(with: nome)
    }
    
    func salvarDadosDoUsuario(nome: String, completion: @escaping(Bool) -> Void) {
        user.nome = nome
        
        repository.save(user: user) {
            print("DEBUG: Usuário cadastrado -> EMAIL: \(self.user.email), SENHA: \(self.user.senha), CONFIRMA SENHA: \(self.user.confirmaSenha), NOME: \(self.user.nome)")
            completion(true)
        } onError: {
            print("DEBUG: Falha ao salvar usuário.")
            completion(false)
        }
    }
}
