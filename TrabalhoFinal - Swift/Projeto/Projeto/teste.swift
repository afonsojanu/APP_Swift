//
//  teste.swift
//  Projeto
//
//  Created by Afonso Januario on 08/06/2023.
//

import SwiftUI

struct PokemonFire: View {
    @ObservedObject var pokemonVM = PokemonViewModel()
    @State private var searchText = ""
    
    var filteredPokemon: [Pokemon] {
            return pokemonVM.pokemon.filter { $0.type.lowercased() == "fire" }
        }
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredPokemon) { poke in
                    NavigationLink(destination: PokemonDetailView(pokemon: poke)) {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(poke.name.capitalized)
                                        .font(.system(size: 20))
                                    if poke.isFavourite {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
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
                                    ProgressView()
                                }
                            }
                        }
                    }
                    .listRowBackground(poke.typeColor)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(action: {addFavorite(pokemon: poke)}) {
                            Image(systemName: "star")
                        }
                        .tint(.yellow)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text("Pokemon")
                            .font(.system(size: 40))
                            .bold()
                        Image("pokebola")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
            }
        }
    }
    func addFavorite(pokemon: Pokemon) {
        if let index = pokemonVM.pokemon.firstIndex(where: {
            $0.id == pokemon.id }) {
            pokemonVM.pokemon[index].isFavourite.toggle()
        }
    }
}

struct teste_Previews: PreviewProvider {
    static var previews: some View {
        PokemonFire()
    }
}
