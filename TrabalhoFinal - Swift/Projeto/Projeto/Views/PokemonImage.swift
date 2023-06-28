//
//  PokemonImage.swift
//  Projeto
//
//  Created by Afonso Januario on 07/06/2023.
//

import SwiftUI

struct PokemonImage: View {
    let imageURL: String // URL da imagem do Pokémon
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            // Se o carregamento da imagem for bem-sucedido mostra a imagem
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
                    .background(Circle().foregroundColor(.white))
                    .shadow(radius: 5)
            } else if phase.error != nil { // Se ocorrer um erro durante o carregamento mostra uma imagem de erro
                Image(systemName: "xmark.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.red, lineWidth: 5))
                    .background(Circle().foregroundColor(.white))
                    .shadow(radius: 5)
            } else {
                ProgressView() // Mostrar uma ProgressView enquanto a imagem está a ser carregada
            }
        }
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage(imageURL: "https://fpfimagehandler.fpf.pt/ScoreImageHandler.ashx?type=Person&id=1711227&op=t&w=202&h=249")
    }
}
