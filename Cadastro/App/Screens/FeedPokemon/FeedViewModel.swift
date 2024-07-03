//
//  FeedViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 20/06/24.
//

import Foundation

protocol FeedViewModelProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> Pokemon
    func loadDataPokemon()
}

enum FeedViewControllerStates {
    case loading
    case loaded
    case error
}

class FeedViewModel: FeedViewModelProtocol {
    private(set) var state: Bindable<FeedViewControllerStates> = Bindable(value: .loading)
    private var service: ServiceProtocol
    private let user: User
    private let repository: Repository
    var pokemonList: [Pokemon] = []
    
    init(service: ServiceProtocol, user: User, repository: Repository) {
        self.service = service
        self.user = user
        self.repository = repository
    }
    
    func numberOfRowsInSection() -> Int {
        return pokemonList.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Pokemon {
        return pokemonList[indexPath.row]
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        var pokemon = pokemonList[indexPath.row]
        pokemon.isFavorited.toggle()
        pokemonList[indexPath.row] = pokemon // Atualiza a lista com o novo estado
        
        if pokemon.isFavorited {
            user.favoritePokemons.append(pokemon.getId)
        } else {
            user.favoritePokemons.removeAll(where: { $0 == pokemon.getId })
        }
        
        repository.updateUser(user: user)
    }
    
    func loadDataPokemon() {
        fetchRequest(url: "https://pokeapi.co/api/v2/pokemon?limit=60&offset=0")
    }
    
    func fetchRequest(url: String) {
        service.getPokemons(url: url) { pokemons in
            self.pokemonList = pokemons
            
            for index in self.pokemonList.indices {
                if self.user.favoritePokemons.contains(self.pokemonList[index].getId) {
                    self.pokemonList[index].isFavorited = true
                }
            }
            self.state.value = .loaded
        } onError: { error in
            self.state.value = .error
        }
    }
}
