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
    
    
    func loadData() {
     
    }
}
