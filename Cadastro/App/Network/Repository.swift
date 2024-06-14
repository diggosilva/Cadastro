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
        do {
            let data = try JSONEncoder().encode(user)
            userDefaults.set(data, forKey: accessKey)
        } catch {
            print("DEBUG: Erro ao codificar usuário: \(error.localizedDescription)")
        }
    }
    
    func getUser(email: String, password: String) -> User? {
        guard let data = userDefaults.object(forKey: accessKey) as? Data else { return nil }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            
            if user.email == email && user.senha == password {
                return user
            } else {
                return nil
            }
        } catch {
            print("DEBUG: Erro ao decodificar usuário: \(error.localizedDescription) ")
            return nil
        }
    }
}
