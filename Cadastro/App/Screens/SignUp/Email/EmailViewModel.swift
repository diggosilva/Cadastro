//
//  EmailViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import Foundation

class EmailViewModel {
    var user = User()
    private var email: String = ""
    
    func enviarEmailPraProximaTela(email: String) {
        user.email = email
    }
}
