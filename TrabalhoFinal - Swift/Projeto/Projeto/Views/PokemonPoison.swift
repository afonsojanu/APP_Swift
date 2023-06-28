//
//  PokemonPoison.swift
//  Projeto
//
//  Created by Afonso Januario on 14/06/2023.
//

import SwiftUI

struct PokemonPoison: View {
    @ObservedObject var pokemonVM = PokemonViewModel()// Objeto que contém os dados e a lógica dos Pokémons
    
    // Filtra os Pokémons pelo seu tipo (Veneno)
    var filteredPokemon: [Pokemon] {
            return pokemonVM.pokemon.filter { $0.type.lowercased() == "poison" }
        }
    
    
    var body: some View {
        NavigationView {
            List {
                // Mostrar a lista dos Pokémons do tipo Veneno
                ForEach(filteredPokemon) { poke in
                    NavigationLink(destination: PokemonDetailView(pokemon: poke)) {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(poke.name.capitalized)
                                        .font(.system(size: 20))
                                }
                                Text(poke.type.capitalized)
                                    .italic()
                            }
                            
                            HStack {
                                Spacer()
                                // Carregar a imagem do Pokémon
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
        }
    }
}

struct PokemonPoison_Previews: PreviewProvider {
    static var previews: some View {
        PokemonPoison()
    }
}
