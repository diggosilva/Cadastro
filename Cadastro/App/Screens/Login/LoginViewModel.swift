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

protocol LoginViewModelProtocol {
    
}

class LoginViewModel {
    var state: Bindable<LoginViewControllerStates> = Bindable(value: .loading)
    let repository = Repository()
    var email: String = ""
    var password: String = ""
    var loggedInUser: User?
    
    func checkIfUserExists() -> Bool {
        loggedInUser = repository.getUser(email: email, password: password)
        return loggedInUser != nil
    }
    
    func loginUser() {
        if checkIfUserExists() {
            state.value = .loaded
            print("DEBUG: Você está logado!")
        } else {
            state.value = .error
            print("DEBUG: Usuário não encontrado!")
        }
    }
}
