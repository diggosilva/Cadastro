//
//  EmailViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import Foundation

class EmailViewModel {
    var cadastro: Cadastro?
    var email: String = ""
    
    init() {
        
    }
    
    init(cadastro: Cadastro) {
        self.cadastro = cadastro
    }
    
    func enviarEmailPraProximaTela(email: String) {
        self.email = email
        print("DEBUG: Email cadastrado: \(self.email)")
    }
}