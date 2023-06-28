//
//  PokemonDetailView.swift
//  Projeto
//
//  Created by Afonso Januario on 07/06/2023.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemon: Pokemon // O Pokémon a ser exibido
    @State private var scale: CGFloat = 0 // Variável para animação
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                // Mostra o nome do Pokémon
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)

                
                // Mostra o tipo do Pokémon
                Text(pokemon.type.capitalized)
                    .italic()
                    .foregroundColor(pokemon.typeColor)
                    
                
                // Mostra a imagem do Pokémon
                PokemonImage(imageURL: pokemon.imageURL)
                    .padding(.bottom, -100)
                    .zIndex(1)
                
                ZStack {
                    // Um retângulo que preenche toda a área disponível com a cor correspondente ao tipo de Pokémon
                    Rectangle()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .foregroundColor(pokemon.typeColor)
                 
                    
                    VStack {
                        // Mostra se o Pokémon é favorito
                        if pokemon.isFavourite {
                            Label("Favorite", systemImage: "star.fill")
                                .foregroundColor(pokemon.typeColor)
                                .padding(5)
                                .background(Capsule()
                                    .foregroundColor(.white))
                        }
                        
                        // Mostra a descrição do Pokémon
                        Text(pokemon.description
                            .replacingOccurrences(of: "\n", with: ""))
                        .foregroundColor(.white)
                        .padding()
                        
                        // Mostra as estatísticas do Pokémon
                        StatsViewGroup(pokemon: pokemon)
                    }
                    // Aplica uma animação quando as estatisticas aparecem
                    .offset(y: -40)
                    .scaleEffect(scale)
                    .onAppear(){
                        let baseAnimation = Animation.spring(dampingFraction: 0.5)
                        let repeated = baseAnimation.repeatCount(1)
                        withAnimation(repeated) {
                            scale = 1
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: PokemonViewModel().MOCK_POKEMON)
    }
}
