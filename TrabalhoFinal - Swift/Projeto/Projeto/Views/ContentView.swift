//
//  ContentView.swift
//  Projeto
//
//  Created by Afonso Januario on 07/06/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var pokemonVM = PokemonViewModel() // Objeto que contém os dados e a lógica dos Pokémons
    @State private var searchText = "" // Texto de pesquisa escrito pelo utilizador
    
    var filteredPokemon: [Pokemon] {
        // Se o campo de pesquisa estiver vazio, retorna a lista completa de Pokémons
        if searchText == "" {
            return pokemonVM.pokemon
        } else {
            // Filtra a lista de Pokémons com base no texto pesquisado
            return pokemonVM.pokemon.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        TabView {
            NavigationView {
                List {
                    ForEach(filteredPokemon) { poke in
                        // Cria uma lista para cada Pokémon
                        NavigationLink(destination: PokemonDetailView(pokemon: poke)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        Text(poke.name.capitalized)
                                            .font(.system(size: 20))
                                        if poke.isFavourite {
                                            // Mostra um círculo branco com uma estrela amarela se o Pokémon for favorito
                                            Circle()
                                                .foregroundColor(.white)
                                                .frame(width: 30, height: 30)
                                                .overlay(
                                                    Image(systemName: "star.fill")
                                                        .foregroundColor(.yellow)
                                                )
                                        }
                                    }
                                    Text(poke.type.capitalized)
                                        .italic()
                                }
                                
                                HStack {
                                    Spacer()
                                    AsyncImage(url: URL(string: poke.imageURL)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100)
                                    } placeholder: {
                                        // Mostra uma ProgressView enquanto a imagem está a ser carregada
                                        ProgressView()
                                    }
                                }
                            }
                        }
                        .listRowBackground(poke.typeColor) // Define a cor de fundo da linha da lista com base no tipo do Pokémon
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(action: { addFavorite(pokemon: poke) }) {
                                // Mostra um botão para adicionar o Pokémon aos favoritos
                                Image(systemName: "star")
                            }
                            .tint(.yellow)
                        }
                    }
                }
                // Titulo da NavigationBar com a imagem da Pokébola
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            Text("Pokémon")
                                .font(.system(size: 40))
                                .bold()
                            Image("pokebola")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                // Adiciona uma barra de pesquisa usando a variavel SearchText
                .searchable(text: $searchText)
            }
            .tabItem {
                Label{
                    Text ("Pokémon")
                } icon: {
                    Image("pokedex")
                        .resizable()
                        .frame(width: 10,height: 10)
                }
            }
            
            // transita para a View do PokemonPoison
            PokemonPoison()
            .tabItem {
                Label{
                    Text ("Poison")
                } icon: {
                    Image("poison")
                        .resizable()
                        .frame(width: 15,height: 15)
                            }
                        }
            
            // transita para a View do PokemonWater
            PokemonWater()
            .tabItem {
                Label{
                    Text ("Water")
                } icon: {
                    Image("water")
                        .resizable()
                        .frame(width: 15,height: 15)
                        }
                    }
            
            // transita para a View do PokemonFire
            PokemonFire()
            .tabItem {
                Label{
                    Text ("Fire")
                } icon: {
                    Image("fire")
                        .resizable()
                        .frame(width: 15,height: 15)
                    }
                }
            
            // transita para a View do PokemonElectric
            PokemonElectric()
            .tabItem {
                Label{
                    Text ("Electric")
                } icon: {
                    Image("electric")
                        .resizable()
                        .frame(width: 15,height: 15)
                    }
                }
        }
    }

    // Função responsável por adicionar ou remover um Pokémon dos Favoritos na lista de Pokémons
    func addFavorite(pokemon: Pokemon) {
        if let index = pokemonVM.pokemon.firstIndex(where: {
            $0.id == pokemon.id }) {
            pokemonVM.pokemon[index].isFavourite.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
