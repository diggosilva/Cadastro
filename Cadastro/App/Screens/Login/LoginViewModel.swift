//
//  LoginViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 06/06/24.
//

import Foundation

enum LoginViewControllerStates {
    case loading
    case loaded
    case error
}

class LoginViewModel {
    var state: Bindable<LoginViewControllerStates> = Bindable(value: .loading)
    var email: String = ""
    var password: String = ""
    private let repository = Repository()
    private var loggedInUser: User?
    
    func areFieldsFilled() -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    func loginUser() {
        guard areFieldsFilled() else {
            print("DEBUG: Campos inválidos.")
            return
        }
        loggedInUser = repository.getUser(email: email, senha: password)
        
        if loggedInUser != nil {
            state.value = .loaded
            print("DEBUG: Você está logado!")
        } else {
            state.value = .error
            print("DEBUG: Email ou senha estão incorretos, ou você não tem um cadastro!")
        }
    }
}
