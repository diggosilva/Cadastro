//
//  Service.swift
//  Cadastro
//
//  Created by Diggo Silva on 20/06/24.
//

import Foundation

protocol ServiceProtocol {
    func getPokemons(url: String, onSuccess: @escaping([FeedModel]) -> Void, onError: @escaping(Error) -> Void)
}

final class Service: ServiceProtocol {
    private var dataTask: URLSessionDataTask?
    
    func getPokemons(url: String, onSuccess: @escaping ([FeedModel]) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = URL(string: url) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse {
                    print("DEBUG: Status code.. \(response.statusCode)")
                }
                do {
                    let feedResponse = try JSONDecoder().decode(FeedResponse.self, from: data ?? Data())
                    var feedModel: [FeedModel] = []
                    
                    for pokemon in feedResponse.results {
                        feedModel.append(FeedModel(name: pokemon.name, url: pokemon.url))
                    }
                    onSuccess(feedModel)
                    print("DEBUG: Lista de Pokemons.. \(feedModel)")
                } catch {
                    onError(error)
                    print("DEBUG: Falha ao decodificar Pokemons \(error.localizedDescription)")
                }
            }
        })
        dataTask?.resume()
    }
}
