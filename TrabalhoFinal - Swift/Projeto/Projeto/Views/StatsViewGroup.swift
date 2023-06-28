//
//  StatsViewGroup.swift
//  Projeto
//
//  Created by Afonso Januario on 07/06/2023.
//

import SwiftUI

struct StatsViewGroup: View {
    var pokemon: Pokemon // O Pokémon para exibir as estatísticas
    
    var body: some View {
        ZStack {
            // Um retângulo branco com opacidade 0.6 e bordas arredondadas
            Rectangle()
                .frame(width: 300, height: 250)
                .foregroundColor(.white)
                .opacity(0.6)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 30) {
// Exibe a estatistica de ataque do Pokémon,com cor vermelha e o respetivo valor de ataque.
                StatView(pokemon: pokemon, statName: "Atk", statColor: .red, statValue: pokemon.attack)
                
// Exibe a estatistica de defesa do Pokémon,com cor azul e o respetivo valor de defesa.
                StatView(pokemon: pokemon, statName: "Def", statColor: .blue, statValue: pokemon.defense)

// Exibe a estatistica de altura do Pokémon,com cor verde-azulado e o respetivo valor de altura.
                StatView(pokemon: pokemon, statName: "Hgt", statColor: .teal, statValue: pokemon.height)
                
// Exibe a estatistica de peso do Pokémon,com cor azul ciano e o respetivo valor de peso.
                StatView(pokemon: pokemon, statName: "Wgt", statColor: .cyan, statValue: pokemon.weight)
            }
        }
    }
}

struct StatsViewGroup_Previews: PreviewProvider {
    static var previews: some View {
        StatsViewGroup(pokemon: PokemonViewModel().MOCK_POKEMON)
    }
}
