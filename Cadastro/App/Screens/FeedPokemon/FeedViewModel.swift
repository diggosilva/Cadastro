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
    private (set) var state: Bindable<FeedViewControllerStates> = Bindable(value: .loading)
    private var service: ServiceProtocol
    private var user: User
    var pokemonList: [Pokemon] = []
    
    init(service: ServiceProtocol, user: User) {
        self.service = service
        self.user = user
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
        
        if pokemon.isFavorited == true {
            user.favoritePokemons.append(pokemon.getId)
        } else {
            user.favoritePokemons.removeAll(where: { $0 == pokemon.getId })
        }
    }
    
    func loadDataPokemon() {
        fetchRequest(url: "https://pokeapi.co/api/v2/pokemon?limit=60&offset=0")
    }
    
    func fetchRequest(url: String) {
        service.getPokemons(url: url) { pokemons in
            self.pokemonList = pokemons
            
            for pokemon in self.pokemonList {
                if self.user.favoritePokemons.contains(pokemon.getId) {
                    var pokemon = pokemon
                    pokemon.isFavorited = true
                }
            }
            
            self.state.value = .loaded
        } onError: { error in
            self.state.value = .error
        }
    }
}
