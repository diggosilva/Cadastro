//
//  Repository.swift
//  Cadastro
//
//  Created by Diggo Silva on 13/06/24.
//

import Foundation

class Repository {
    let userDefaults = UserDefaults.standard
    let accessKey = "accessKey"
    
    func save(user: User) {
        var userList = pegaListaDeUsuarios()
        
        let checkEmail = userList.contains(where: { $0.email == user.email })
        if checkEmail {
            print("DEBUG: Este email já está sendo usado.")
            return
        }
        userList.append(user)
        salvaListaDeUsuarios(userList: userList)
    }
    
    private func salvaListaDeUsuarios(userList: [User]) {
        do {
            let data = try JSONEncoder().encode(userList)
            userDefaults.set(data, forKey: accessKey)
        } catch {
            print("DEBUG: Erro ao codificar usuário: \(error.localizedDescription)")
        }
    }
    
    private func pegaListaDeUsuarios() -> [User] {
        guard let data = userDefaults.object(forKey: accessKey) as? Data else { return [] }
        do {
            let userList = try JSONDecoder().decode([User].self, from: data)
            return userList
        } catch {
            print("DEBUG: Erro ao decodificar usuário: \(error.localizedDescription)")
            return []
        }
    }
    
    func getUser(email: String, senha: String) -> User? {
        let userList = pegaListaDeUsuarios()
        let checkUser = userList.first(where: { $0.email == email && $0.senha == senha })
        return checkUser
    }
}
