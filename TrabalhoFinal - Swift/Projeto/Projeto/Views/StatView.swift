//
//  StatView.swift
//  Projeto
//
//  Created by Afonso Januario on 07/06/2023.
//

import SwiftUI

struct StatView: View {
    var pokemon: Pokemon // O Pokémon a ser exibido nos detalhes dos status
    var statName: String // Nome do status
    var statColor: Color // Cor da barra de progresso do status
    var statValue: Int // Valor do status
    
    var body: some View {
        HStack {
            Text(statName) // Mostra o nome do status
                .font(.system(.body, design: .monospaced))
            
            ZStack(alignment: .leading) {
                // Mostra um retângulo cinza como fundo da barra de progresso
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.gray)
                    .frame(width: 150, height: 20)
                
                // Mostra a barra de progresso com a cor específica do status
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(statColor)
                    .frame(width: statValue <= 100 ? 150 * (CGFloat(statValue) / 100) : 150, height: 20) // A largura da barra de progresso depende do valor do status
                    
            }
            Text("\(statValue)") // Mostra o valor numérico do status
                .font(.system(.body, design: .monospaced))
        }
    }
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView(pokemon: PokemonViewModel().MOCK_POKEMON, statName: "Atk", statColor: .red, statValue: 55)
    }
}
