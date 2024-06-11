//
//  EmailViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import Foundation

class EmailViewModel {
    var cadastro = Cadastro()
    private var email: String = ""
    
    func enviarEmailPraProximaTela(email: String) {
        cadastro.email = email
//        let dataTransferObject = email
        print("DEBUG: Email foi cadastrado: \(cadastro.email)")
    }
}
