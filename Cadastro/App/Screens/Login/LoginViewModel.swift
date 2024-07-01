//
//  LoginViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 06/06/24.
//

import Foundation

enum LoginViewControllerStates {
    case waitingLog
    case logged(User)
    case error
}

class LoginViewModel {
    var state: Bindable<LoginViewControllerStates> = Bindable(value: .waitingLog)
    var email: String = ""
    var password: String = ""
    private let repository = Repository()
    var loggedInUser: User?
    
    func areFieldsFilled() -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    func loginUser() {
        guard areFieldsFilled() else {
            print("DEBUG: Campos inválidos.")
            return
        }
        loggedInUser = repository.getUser(email: email, senha: password)
        
        guard let logUser = loggedInUser else {
            state.value = .error
            print("DEBUG: Email ou senha estão incorretos, ou você não tem um cadastro!")
            return
        }
        state.value = .logged(logUser)
        print("DEBUG: Você está logado!")
    }
}
